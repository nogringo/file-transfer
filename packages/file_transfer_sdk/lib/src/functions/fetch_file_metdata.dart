import 'package:file_transfer_sdk/file_transfer_sdk.dart';
import 'package:ndk/ndk.dart';
import 'package:ndk/shared/nips/nip01/bip340.dart';

Future<FileMetadata> fetchFileMetadata({
  required Ndk ndk,
  required SharedFile sharedFile,
}) async {
  final decodedNevent = Nip19.decodeNevent(sharedFile.nevent);

  final query = ndk.requests.query(
    filter: Filter(ids: [decodedNevent.eventId]),
  );

  Nip01Event? giftWrap;
  await for (var event in query.stream) {
    if (event.id != decodedNevent.eventId) continue;
    giftWrap = event;
    break;
  }

  if (giftWrap == null) throw Exception("Event not found");

  final privateKey = Nip19.decode(sharedFile.encodedPrivateKey);
  final publicKey = Bip340.getPublicKey(privateKey);
  final signer = Bip340EventSigner(
    privateKey: privateKey,
    publicKey: publicKey,
  );

  final event = await ndk.giftWrap.fromGiftWrap(
    giftWrap: giftWrap,
    customSigner: signer,
  );

  return FileMetadata.fromEvent(event);
}
