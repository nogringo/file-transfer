import 'dart:convert';
import 'dart:typed_data';

import 'package:pointycastle/export.dart';

/// Decrypts data using AES-256-GCM
/// [encryptedBytes] - the encrypted data
/// [key] - base64 encoded encryption key
/// [nonce] - base64 encoded nonce (salt)
Future<Uint8List> decryptBlob({
  required Uint8List encryptedBytes,
  required String key,
  required String nonce,
}) async {
  // Decode base64 key and nonce
  final keyBytes = base64Decode(key);
  final nonceBytes = base64Decode(nonce);

  // Set up AES-GCM parameters
  final keyParam = KeyParameter(keyBytes);
  final params = ParametersWithIV(keyParam, nonceBytes);

  // Create and initialize the cipher for decryption (false = decrypt)
  final aesGcm = GCMBlockCipher(AESEngine());
  aesGcm.init(false, params);

  // Decrypt the data
  final decryptedData = aesGcm.process(encryptedBytes);

  return decryptedData;
}
