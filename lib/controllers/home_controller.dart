import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:file_transfer/functions/share_file.dart';
import 'package:file_transfer/models/shared_file.dart';
import 'package:file_transfer/routes.dart';
import 'package:file_transfer/utils/platform_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';
import 'package:mime/mime.dart';

class HomePageController extends GetxController {
  final _sharedFile = Rxn<SharedFile>();
  final _isUploading = false.obs;
  final _error = RxnString();
  final _isDragging = false.obs;
  final dropzoneController = Rxn<DropzoneViewController>();

  SharedFile? get sharedFile => _sharedFile.value;
  bool get isUploading => _isUploading.value;
  String? get error => _error.value;
  bool get isDragging => _isDragging.value;
  bool get isWeb => kIsWeb;

  Future<void> handleDroppedFile(dynamic file) async {
    _isDragging.value = false;
    _isUploading.value = true;
    _error.value = null;

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

      final sharedFile = await shareFile(
        bytes: bytes,
        contentType: mimeType,
        filename: filename,
      );

      _sharedFile.value = sharedFile;
      _isUploading.value = false;
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
    _isUploading.value = true;
    _error.value = null;

    try {
      final pickResult = await FilePicker.platform.pickFiles(
        type: FileType.any,
        withData: true,
      );

      if (pickResult == null || pickResult.files.isEmpty) {
        _isUploading.value = false;
        return;
      }

      final file = pickResult.files.first;
      if (file.bytes == null) {
        _error.value = 'Unable to read file data';
        _isUploading.value = false;
        return;
      }

      final mimeType = lookupMimeType(
        file.name,
        headerBytes: file.bytes?.take(8).toList(),
      );

      final sharedFile = await shareFile(
        bytes: file.bytes!,
        contentType: mimeType,
        filename: file.name,
      );

      _sharedFile.value = sharedFile;
      _isUploading.value = false;
    } catch (e) {
      _error.value = e.toString();
      _isUploading.value = false;
    }
  }

  void copyToClipboard(String text, String label) {
    Clipboard.setData(ClipboardData(text: text));
    Get.snackbar(
      'Copied',
      '$label copied to clipboard',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
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
    _error.value = null;
  }

  Future<void> pasteAndOpenLink() async {
    final clipboardData = await Clipboard.getData('text/plain');
    final link = clipboardData?.text;

    if (link == null || link.isEmpty) {
      Get.snackbar(
        'No Link',
        'No link found in clipboard',
        snackPosition: SnackPosition.BOTTOM,
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

    Get.snackbar(
      'Invalid Link',
      'Please copy a valid share link',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
