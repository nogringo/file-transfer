import 'dart:convert';

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

  Nip01Event? event;
  await for (var e in query.stream) {
    if (e.id != decodedNevent.eventId) continue;
    event = e;
    break;
  }

  if (event == null) throw Exception("Event not found");

  final privateKey = Nip19.decode(sharedFile.encodedPrivateKey);
  final publicKey = Bip340.getPublicKey(privateKey);
  final signer = Bip340EventSigner(
    privateKey: privateKey,
    publicKey: publicKey,
  );

  final decryptedContent = await signer.decryptNip44(
    ciphertext: event.content,
    senderPubKey: event.pubKey,
  );

  List<List<String>> tags = (jsonDecode(decryptedContent!) as List)
      .map((tag) => List<String>.from(tag as List))
      .toList();

  return FileMetadata.fromTags(tags);
}
