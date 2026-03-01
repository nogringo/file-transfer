import 'package:file_transfer/functions/fetch_blob.dart';
import 'package:file_transfer/functions/fetch_file_metdata.dart';
import 'package:file_transfer/models/file_metadata.dart';
import 'package:file_transfer/models/shared_file.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ndk/ndk.dart';
import 'package:path/path.dart' as p;
import 'package:toastification/toastification.dart';

class FileShareController extends GetxController {
  final _isLoading = false.obs;
  final _isFetchingMetadata = false.obs;
  final _error = RxnString();
  final _decryptedData = Rxn<Uint8List>();
  final _metadata = Rxn<FileMetadata>();
  final _hasStarted = false.obs;

  bool get isLoading => _isLoading.value;
  bool get isFetchingMetadata => _isFetchingMetadata.value;
  String? get error => _error.value;
  Uint8List? get decryptedData => _decryptedData.value;
  FileMetadata? get metadata => _metadata.value;
  bool get hasStarted => _hasStarted.value;

  @override
  void onInit() {
    super.onInit();
    _fetchMetadata();
  }

  Future<void> _fetchMetadata() async {
    final nevent = Get.parameters['nevent'] ?? '';
    final encodedPrivateKey = Get.parameters['encodedPrivateKey'] ?? '';

    if (nevent.isEmpty || encodedPrivateKey.isEmpty) {
      _error.value = 'Invalid link: missing nevent or private key';
      update();
      return;
    }

    _isFetchingMetadata.value = true;
    _error.value = null;
    update();

    try {
      final ndk = Get.find<Ndk>();

      final sharedFile = SharedFile(
        nevent: nevent,
        encodedPrivateKey: encodedPrivateKey,
      );

      final metadata = await fetchFileMetadata(
        ndk: ndk,
        sharedFile: sharedFile,
      );

      _metadata.value = metadata;
      _isFetchingMetadata.value = false;
      update();
    } catch (e) {
      _error.value = e.toString();
      _isFetchingMetadata.value = false;
      update();
    }
  }

  Future<void> startDecrypt() async {
    if (_hasStarted.value) return;
    _hasStarted.value = true;
    update();

    final nevent = Get.parameters['nevent'] ?? '';
    final encodedPrivateKey = Get.parameters['encodedPrivateKey'] ?? '';

    if (nevent.isEmpty || encodedPrivateKey.isEmpty) {
      _error.value = 'Invalid link: missing nevent or private key';
      _isLoading.value = false;
      update();
      return;
    }

    _isLoading.value = true;
    _error.value = null;
    update();

    try {
      final ndk = Get.find<Ndk>();

      final sharedFile = SharedFile(
        nevent: nevent,
        encodedPrivateKey: encodedPrivateKey,
      );

      final metadata = await fetchFileMetadata(
        ndk: ndk,
        sharedFile: sharedFile,
      );

      final decryptedBytes = await fetchBlob(ndk: ndk, fileMetadata: metadata);

      _decryptedData.value = decryptedBytes;
      _metadata.value = metadata;
      _isLoading.value = false;
      update();

      // Auto-save after decrypt
      await saveFile();
    } catch (e) {
      _error.value = e.toString();
      _isLoading.value = false;
      update();
    }
  }

  Future<void> saveFile() async {
    if (_decryptedData.value == null) return;

    try {
      final mimeType = _metadata.value?.fileType ?? 'application/octet-stream';
      final filename = _metadata.value?.filename ?? 'downloaded_file';

      final nameWithoutExt = p.withoutExtension(filename);
      final ext = p.extension(filename).replaceFirst('.', '');

      await FileSaver.instance.saveFile(
        name: nameWithoutExt,
        bytes: _decryptedData.value!,
        fileExtension: ext.isEmpty ? mimeType.split('/').last : ext,
        mimeType: MimeType.other,
        customMimeType: mimeType,
      );

      toastification.show(
        type: ToastificationType.success,
        style: ToastificationStyle.flatColored,
        title: const Text('File saved'),
        autoCloseDuration: const Duration(seconds: 2),
        alignment: Alignment.bottomCenter,
      );
    } catch (e) {
      toastification.show(
        type: ToastificationType.error,
        style: ToastificationStyle.flatColored,
        title: Text('Failed to save: $e'),
        autoCloseDuration: const Duration(seconds: 3),
        alignment: Alignment.bottomCenter,
      );
    }
  }

  void reset() {
    _decryptedData.value = null;
    _metadata.value = null;
    _error.value = null;
    _hasStarted.value = false;
  }
}
