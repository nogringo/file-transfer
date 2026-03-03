import 'dart:convert';

import 'package:ndk/ndk.dart';

Future<Nip01Event> createEvent({
  required Ndk ndk,
  required BlobDescriptor descriptor,
  required String recipientPubkey,
  required String key,
  required String nonce,
  String? filename,
}) async {
  final fileMetadata = [
    if (descriptor.type != null) ["file-type", descriptor.type!],
    if (filename != null && filename.isNotEmpty) ["filename", filename],
    ["encryption-algorithm", "aes-gcm"],
    ["decryption-key", key],
    ["decryption-nonce", nonce],
    ["x", descriptor.sha256],
    if (descriptor.size != null) ["size", descriptor.size.toString()],
  ];

  final signer = ndk.accounts.getLoggedAccount()!.signer;
  final content = await ndk.accounts.getLoggedAccount()!.signer.encryptNip44(
    plaintext: jsonEncode(fileMetadata),
    recipientPubKey: recipientPubkey,
  );

  final event = Nip01Event(
    pubKey: signer.getPublicKey(),
    kind: 1515,
    tags: [
      ["p", recipientPubkey],
    ],
    content: content!,
  );

  final signedEvent = await signer.sign(event);

  return signedEvent;
}
