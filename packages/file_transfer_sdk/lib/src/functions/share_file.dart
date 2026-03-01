import 'dart:typed_data';

import 'package:file_transfer_sdk/file_transfer_sdk.dart';
import 'package:file_transfer_sdk/src/constants.dart';

import 'create_event.dart';
import 'encrypt_blob.dart';
import 'upload_blob.dart';
import 'package:ndk/ndk.dart';
import 'package:ndk/shared/nips/nip01/bip340.dart';

Future<SharedFile> shareFile({
  required Ndk ndk,
  required Uint8List bytes,
  String? contentType,
  String? filename,
}) async {
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
    filename: filename,
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
