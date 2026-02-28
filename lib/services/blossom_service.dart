import 'dart:typed_data';
import 'package:ndk/ndk.dart';

class BlossomService {
  final Ndk _ndk;

  BlossomService(this._ndk);

  /// Upload un blob sur un serveur Blossom en utilisant NDK
  /// 
  /// Retourne les informations du fichier uploadé
  Future<BlobUploadResult> upload(Uint8List data, {List<String>? servers}) async {
    final results = await _ndk.blossom.uploadBlob(
      data: data,
      serverUrls: servers,
    );

    if (results.isEmpty) {
      throw Exception('Upload failed: no results returned');
    }

    return results.first;
  }

  /// Upload avec stratégie de miroir
  Future<List<BlobUploadResult>> uploadWithMirror(
    Uint8List data, {
    List<String>? servers,
  }) async {
    return await _ndk.blossom.uploadBlob(
      data: data,
      serverUrls: servers,
      strategy: UploadStrategy.mirrorAfterSuccess,
    );
  }

  /// Télécharge un blob par son hash SHA-256
  Future<Uint8List> downloadByHash(String sha256, {List<String>? servers}) async {
    final result = await _ndk.blossom.getBlob(
      sha256: sha256,
      serverUrls: servers,
    );
    return result.data;
  }

  /// Upload sur un serveur spécifique
  Future<BlobUploadResult> uploadToServer(
    Uint8List data, {
    required String serverUrl,
  }) async {
    return await upload(data, servers: [serverUrl]);
  }
}
