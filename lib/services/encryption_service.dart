import 'dart:typed_data';
import 'dart:math' as math;
import 'package:crypto/crypto.dart';
import 'package:pointycastle/export.dart';

class EncryptionService {
  static final math.Random _random = math.Random.secure();

  /// Chiffre des données avec AES-GCM (256 bits)
  ///
  /// Retourne un map contenant:
  /// - encryptedData: les données chiffrées
  /// - key: la clé utilisée (32 bytes)
  /// - iv: le vecteur d'initialisation (12 bytes pour GCM)
  /// - authTag: le tag d'authentification (16 bytes)
  static Map<String, Uint8List> encrypt(Uint8List data) {
    // Générer une clé aléatoire 256 bits (32 bytes)
    final keyBytes = Uint8List(32);
    for (var i = 0; i < keyBytes.length; i++) {
      keyBytes[i] = _random.nextInt(256);
    }

    // Générer un IV aléatoire 96 bits (12 bytes) - recommandé pour GCM
    final ivBytes = Uint8List(12);
    for (var i = 0; i < ivBytes.length; i++) {
      ivBytes[i] = _random.nextInt(256);
    }

    // Chiffreur AES-GCM
    final cipher = GCMBlockCipher(AESEngine())
      ..init(
        true,
        AEADParameters(
          KeyParameter(keyBytes),
          128, // Tag size en bits (16 bytes)
          ivBytes,
          Uint8List(0), // Données additionnelles vides
        ),
      );

    // Chiffrer les données
    final encryptedData = _processBytes(cipher, data);

    // GCM produit un tag de 16 bytes qui est appendu à la fin
    // On le sépare pour le retour
    final authTag = encryptedData.sublist(encryptedData.length - 16);
    final ciphertext = encryptedData.sublist(0, encryptedData.length - 16);

    return {
      'encryptedData': ciphertext,
      'key': keyBytes,
      'iv': ivBytes,
      'authTag': authTag,
    };
  }

  /// Déchiffre des données avec AES-GCM
  static Uint8List decrypt({
    required Uint8List encryptedData,
    required Uint8List key,
    required Uint8List iv,
    required Uint8List authTag,
  }) {
    // Combiner ciphertext + authTag pour le déchiffrement
    final combined = Uint8List(encryptedData.length + authTag.length);
    combined.setRange(0, encryptedData.length, encryptedData);
    combined.setRange(encryptedData.length, combined.length, authTag);

    final cipher = GCMBlockCipher(AESEngine())
      ..init(
        false,
        AEADParameters(
          KeyParameter(key),
          128, // Tag size en bits
          iv,
          Uint8List(0), // Données additionnelles vides
        ),
      );

    return _processBytes(cipher, combined);
  }

  static Uint8List _processBytes(BlockCipher cipher, Uint8List data) {
    final out = Uint8List(data.length + cipher.blockSize);
    var offset = 0;

    for (var i = 0; i < data.length; i += cipher.blockSize) {
      offset += cipher.processBlock(data, i, out, offset);
    }

    return out.sublist(0, offset);
  }

  /// Génère un hash SHA-256 des données
  static Uint8List hash(Uint8List data) {
    final digest = sha256.convert(data);
    return Uint8List.fromList(digest.bytes);
  }

  /// Convertit Uint8List en hex string
  static String toHex(Uint8List bytes) {
    return bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
  }

  /// Convertit hex string en Uint8List
  static Uint8List fromHex(String hex) {
    if (hex.length % 2 != 0) {
      throw ArgumentError('Hex string must have even length');
    }
    final bytes = <int>[];
    for (var i = 0; i < hex.length; i += 2) {
      bytes.add(int.parse(hex.substring(i, i + 2), radix: 16));
    }
    return Uint8List.fromList(bytes);
  }
}
