import 'package:ndk/ndk.dart';

class FileMetadata {
  final String? fileType;
  final String? filename;
  final String key;
  final String nonce;
  final String x;
  final String? ox;
  final int? size;

  FileMetadata({
    required this.fileType,
    required this.filename,
    required this.key,
    required this.nonce,
    required this.x,
    required this.ox,
    required this.size,
  });

  factory FileMetadata.fromEvent(Nip01Event event) {
    return FileMetadata(
      fileType: event.getFirstTag('file-type'),
      filename: event.getFirstTag('filename'),
      key: event.getFirstTag('decryption-key') ?? '',
      nonce: event.getFirstTag('decryption-nonce') ?? '',
      x: event.getFirstTag('x') ?? '',
      ox: event.getFirstTag('ox'),
      size: int.tryParse(event.getFirstTag('size') ?? ''),
    );
  }
}
