import 'package:flutter/foundation.dart';

class FileInfo {
  final String name;
  final int size;
  final String? mimeType;
  final DateTime? lastModified;
  final Uint8List bytes;

  FileInfo({
    required this.name,
    required this.size,
    this.mimeType,
    this.lastModified,
    required this.bytes,
  });
}
