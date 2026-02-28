import 'dart:typed_data';

import 'package:file_transfer/constants.dart';
import 'package:ndk/ndk.dart';

Future<BlobDescriptor?> uploadBlob({
  required Ndk ndk,
  required Uint8List data,
  String? contentType,
}) async {
  final serverUrls = Constants.blossomServers;

  final blobUploadResults = await ndk.blossom.uploadBlob(
    data: data,
    serverUrls: serverUrls,
    contentType: contentType,
  );

  return blobUploadResults.firstWhere((e) => e.success).descriptor;
}
