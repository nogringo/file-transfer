import 'dart:typed_data';

import 'package:file_transfer_sdk/file_transfer_sdk.dart';
import 'package:file_transfer_sdk/src/constants.dart';

import 'decrypt_blob.dart';
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
