import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:file_transfer/models/file_info.dart';
import 'package:file_transfer/routes.dart';
import 'package:file_transfer/utils/platform_helper.dart';
import 'package:file_transfer_sdk/file_transfer_sdk.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';
import 'package:mime/mime.dart';
import 'package:toastification/toastification.dart';

class HomePageController extends GetxController {
  final _sharedFile = Rxn<SharedFile>();
  final _fileInfo = Rxn<FileInfo>();
  final _isUploading = false.obs;
  final _error = RxnString();
  final _isDragging = false.obs;
  final dropzoneController = Rxn<DropzoneViewController>();

  SharedFile? get sharedFile => _sharedFile.value;
  FileInfo? get fileInfo => _fileInfo.value;
  bool get isUploading => _isUploading.value;
  String? get error => _error.value;
  bool get isDragging => _isDragging.value;
  bool get isWeb => kIsWeb;

  void _showToast(
    String message, {
    ToastificationType type = ToastificationType.info,
  }) {
    toastification.show(
      type: type,
      style: ToastificationStyle.flatColored,
      title: Text(message),
      autoCloseDuration: const Duration(seconds: 2),
      alignment: Alignment.bottomCenter,
    );
  }

  Future<void> _uploadFile(Uint8List bytes, String filename) async {
    _isUploading.value = true;
    _error.value = null;

    try {
      final mimeType = lookupMimeType(
        filename,
        headerBytes: bytes.take(8).toList(),
      );

      final sharedFile = await shareFile(
        ndk: Get.find(),
        bytes: bytes,
        contentType: mimeType,
        filename: filename,
      );

      _sharedFile.value = sharedFile;
      _fileInfo.value = null;
    } catch (e) {
      _error.value = e.toString();
    } finally {
      _isUploading.value = false;
    }
  }

  void _setFileInfo(Uint8List bytes, String filename, String? mimeType) {
    _fileInfo.value = FileInfo(
      name: filename,
      size: bytes.length,
      mimeType: mimeType,
      bytes: bytes,
    );
  }

  Future<void> handleDroppedFile(dynamic file) async {
    _isDragging.value = false;

    try {
      String filename;
      Uint8List bytes;

      if (kIsWeb && file is DropzoneFileInterface) {
        // Web: use dropzone controller
        filename = await dropzoneController.value!.getFilename(file);
        bytes = await dropzoneController.value!.getFileData(file);
      } else if (file is String) {
        // Desktop: file path
        final filePath = file;
        final fileObj = File(filePath);
        filename = fileObj.uri.pathSegments.last;
        bytes = await fileObj.readAsBytes();
      } else {
        throw Exception('Unsupported file type: ${file.runtimeType}');
      }

      final mimeType = lookupMimeType(
        filename,
        headerBytes: bytes.take(8).toList(),
      );

      _setFileInfo(bytes, filename, mimeType);
    } catch (e) {
      _error.value = e.toString();
      _isUploading.value = false;
    }
  }

  void onDragHover() {
    _isDragging.value = true;
  }

  void onDragLeave() {
    _isDragging.value = false;
  }

  Future<void> pickAndShareFile() async {
    final pickResult = await FilePicker.platform.pickFiles(
      type: FileType.any,
      withData: true,
    );

    if (pickResult == null || pickResult.files.isEmpty) {
      return;
    }

    final file = pickResult.files.first;
    if (file.bytes == null) {
      _error.value = 'Unable to read file data';
      return;
    }

    final mimeType = lookupMimeType(
      file.name,
      headerBytes: file.bytes?.take(8).toList(),
    );

    _setFileInfo(file.bytes!, file.name, mimeType);
  }

  Future<void> startUpload() async {
    final fileInfo = _fileInfo.value;
    if (fileInfo == null) {
      _error.value = 'No file selected';
      return;
    }

    await _uploadFile(fileInfo.bytes, fileInfo.name);
  }

  void copyToClipboard(String text, String label) {
    Clipboard.setData(ClipboardData(text: text));
    _showToast('$label copied to clipboard');
  }

  void copyShareLink() {
    if (_sharedFile.value == null) return;
    final link = PlatformHelper.buildShareLink(
      _sharedFile.value!.nevent,
      _sharedFile.value!.encodedPrivateKey,
    );
    copyToClipboard(link, 'Share link');
  }

  void reset() {
    _sharedFile.value = null;
    _fileInfo.value = null;
    _error.value = null;
  }

  Future<void> pasteAndOpenLink() async {
    final clipboardData = await Clipboard.getData('text/plain');
    final link = clipboardData?.text;

    if (link == null || link.isEmpty) {
      _showToast(
        'No link found in clipboard',
        type: ToastificationType.warning,
      );
      return;
    }

    // Parse link by splitting on "/" and finding nevent/nsec
    try {
      final segments = link.split('/').where((s) => s.isNotEmpty).toList();

      // nevent and nsec are always the last two segments
      if (segments.length >= 2) {
        final nsec = segments.last;
        final nevent = segments[segments.length - 2];

        // Validate NIP-19 format
        if (nevent.startsWith('nevent1') && nsec.startsWith('nsec1')) {
          // Navigate to file share page with values in URL
          Get.toNamed(AppRoutes.fileShareRoute(nevent, nsec));
          return;
        }
      }
    } catch (e) {
      // Invalid URL
    }

    _showToast('Invalid share link format', type: ToastificationType.error);
  }
}
