import 'dart:typed_data';

import 'package:file_transfer_sdk/file_transfer_sdk.dart';
import 'package:file_transfer_sdk/src/constants.dart';

import 'create_event.dart';
import 'encrypt_blob.dart';
import 'upload_blob.dart';
import 'package:ndk/ndk.dart';
import 'package:ndk/shared/nips/nip01/bip340.dart';

Future<SharedFile> shareFile({
  required Uint8List bytes,
  String? contentType,
  String? filename,
  Ndk? ndk,
}) async {
  final ndk0 =
      ndk ??
      Ndk(
        NdkConfig(
          eventVerifier: Bip340EventVerifier(),
          cache: MemCacheManager(),
          bootstrapRelays: [],
        ),
      );

  if (ndk == null) {
    final keyPair = Bip340.generatePrivateKey();
    ndk0.accounts.loginPrivateKey(
      pubkey: keyPair.publicKey,
      privkey: keyPair.privateKey!,
    );
  }

  final recipientKeyPair = Bip340.generatePrivateKey();

  final encryptedBlob = await encryptBlob(bytes);

  final blobDescriptor = await uploadBlob(
    ndk: ndk0,
    data: encryptedBlob.bytes,
    contentType: contentType,
  );

  final event = await createEvent(
    ndk: ndk0,
    descriptor: blobDescriptor!,
    recipientPubkey: recipientKeyPair.publicKey,
    key: encryptedBlob.key,
    nonce: encryptedBlob.nonce,
    filename: filename,
  );

  await ndk0.broadcast
      .broadcast(nostrEvent: event, specificRelays: Constants.relays)
      .broadcastDoneFuture;

  final nevent = Nip19.encodeNevent(
    eventId: event.id,
    relays: Constants.relays,
  );

  final nsec = Nip19.encodePrivateKey(recipientKeyPair.privateKey!);

  if (ndk == null) await ndk0.destroy();

  return SharedFile(nevent: nevent, encodedPrivateKey: nsec);
}
