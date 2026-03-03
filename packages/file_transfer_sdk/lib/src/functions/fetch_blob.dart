import 'dart:typed_data';

import 'package:file_transfer_sdk/file_transfer_sdk.dart';
import 'package:file_transfer_sdk/src/constants.dart';

import 'decrypt_blob.dart';
import 'package:ndk/ndk.dart';

Future<Uint8List> fetchBlob({
  required FileMetadata fileMetadata,
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

  final blobResponse = await ndk0.blossom.getBlob(
    sha256: fileMetadata.x,
    serverUrls: Constants.blossomServers,
  );

  final decryptedBytes = await decryptBlob(
    encryptedBytes: blobResponse.data,
    key: fileMetadata.key,
    nonce: fileMetadata.nonce,
  );

  if (ndk == null) await ndk0.destroy();

  return decryptedBytes;
}
