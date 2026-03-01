import 'package:ndk/ndk.dart';
import 'package:ndk/shared/nips/nip01/bip340.dart';

Future<Nip01Event> createEvent({
  required Ndk ndk,
  required BlobDescriptor descriptor,
  required String recipientPubkey,
  required String key,
  required String nonce,
  String? filename,
}) async {
  final keyPair = Bip340.generatePrivateKey();
  final signer = Bip340EventSigner(
    privateKey: keyPair.privateKey,
    publicKey: keyPair.publicKey,
  );

  final rumor = Nip01Event(
    pubKey: signer.publicKey,
    kind: 15,
    tags: [
      if (descriptor.type != null) ["file-type", descriptor.type!],
      if (filename != null && filename.isNotEmpty) ["filename", filename],
      ["encryption-algorithm", "aes-gcm"],
      ["decryption-key", key],
      ["decryption-nonce", nonce],
      ["x", descriptor.sha256],
      if (descriptor.size != null) ["size", descriptor.size.toString()],
    ],
    content: descriptor.url,
  );

  final giftwrap = await ndk.giftWrap.toGiftWrap(
    rumor: rumor,
    recipientPubkey: recipientPubkey,
    customSigner: signer,
  );

  return giftwrap;
}
