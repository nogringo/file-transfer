import 'dart:typed_data';

import 'package:file_transfer/constants.dart';
import 'package:file_transfer/functions/decrypt_blob.dart';
import 'package:file_transfer/models/file_metadata.dart';
import 'package:ndk/ndk.dart';

Future<Uint8List> fetchBlob({
  required Ndk ndk,
  required FileMetadata fileMetadata,
}) async {
  final blobResponse = await ndk.blossom.getBlob(
    sha256: fileMetadata.x,
    serverUrls: Constants.blossomServers,
  );

  final decryptedBytes = await decryptBlob(
    encryptedBytes: blobResponse.data,
    key: fileMetadata.key,
    nonce: fileMetadata.nonce,
  );

  return decryptedBytes;
}
