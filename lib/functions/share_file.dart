import 'package:file_transfer/constants.dart';
import 'package:file_transfer/functions/create_event.dart';
import 'package:file_transfer/functions/encrypt_blob.dart';
import 'package:file_transfer/functions/upload_blob.dart';
import 'package:file_transfer/models/shared_file.dart';
import 'package:flutter/foundation.dart';
import 'package:ndk/ndk.dart';
import 'package:ndk/shared/nips/nip01/bip340.dart';
import 'package:ndk_flutter/ndk_flutter.dart';

Future<SharedFile> shareFile({
  required Uint8List bytes,
  String? contentType,
}) async {
  final ndk = Ndk(
    NdkConfig(
      eventVerifier: kIsWeb ? WebEventVerifier() : Bip340EventVerifier(),
      cache: MemCacheManager(),
    ),
  );

  final keyPair = Bip340.generatePrivateKey();
  ndk.accounts.loginPrivateKey(
    pubkey: keyPair.publicKey,
    privkey: keyPair.privateKey!,
  );

  final recipientKeyPair = Bip340.generatePrivateKey();

  final encryptedBlob = await encryptBlob(bytes);

  final blobDescriptor = await uploadBlob(
    ndk: ndk,
    data: encryptedBlob.bytes,
    contentType: contentType,
  );

  final event = await createEvent(
    ndk: ndk,
    descriptor: blobDescriptor!,
    recipientPubkey: recipientKeyPair.publicKey,
    key: encryptedBlob.key,
    nonce: encryptedBlob.nonce,
  );

  await ndk.broadcast
      .broadcast(nostrEvent: event, specificRelays: Constants.relays)
      .broadcastDoneFuture;

  final nevent = Nip19.encodeNevent(
    eventId: event.id,
    relays: Constants.relays,
  );

  final nsec = Nip19.encodePrivateKey(recipientKeyPair.privateKey!);

  return SharedFile(nevent: nevent, encodedPrivateKey: nsec);
}
