import 'dart:convert';
import 'dart:typed_data';

import 'package:file_transfer/models/encrypted_blob.dart';
import 'package:pointycastle/export.dart';

/// Encrypts data using AES-256-GCM
/// Returns the encrypted blob with key, nonce, and auth tag
Future<EncryptedBlob> encryptBlob(Uint8List bytes) async {
  // Generate random 256-bit key (32 bytes)
  final key = _generateRandomBytes(32);

  // Generate random 12-byte nonce (96 bits - recommended for GCM)
  final nonce = _generateRandomBytes(12);

  // Set up AES-GCM parameters
  final keyParam = KeyParameter(key);
  final params = ParametersWithIV(keyParam, nonce);

  // Create and initialize the cipher for encryption (true = encrypt)
  final aesGcm = GCMBlockCipher(AESEngine());
  aesGcm.init(true, params);

  // Encrypt the data
  final encryptedData = aesGcm.process(bytes);

  return EncryptedBlob(
    bytes: encryptedData,
    key: base64Encode(key),
    nonce: base64Encode(nonce),
  );
}

Uint8List _generateRandomBytes(int length) {
  final secureRandom = SecureRandom('Fortuna');
  // Seed with platform entropy
  final seed = Uint8List(32);
  for (var i = 0; i < 32; i++) {
    seed[i] = (DateTime.now().microsecondsSinceEpoch >> (i % 32)) & 0xFF;
  }
  secureRandom.seed(KeyParameter(seed));

  return secureRandom.nextBytes(length);
}
