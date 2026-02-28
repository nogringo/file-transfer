import 'package:file_transfer/controllers/file_share_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuccessView extends GetView<FileShareController> {
  const SuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    final metadata = controller.metadata;
    final decryptedData = controller.decryptedData!;
    final isSmallScreen = MediaQuery.of(context).size.width < 600;
    final colorScheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 16 : 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: MediaQuery.of(context).padding.top),
              Icon(
                Icons.check_circle_rounded,
                size: isSmallScreen ? 56 : 72,
                color: colorScheme.primary,
              ),
              SizedBox(height: isSmallScreen ? 20 : 24),
              Text(
                'File downloaded successfully!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isSmallScreen ? 16 : 18,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              SizedBox(height: isSmallScreen ? 6 : 8),
              Text(
                'Size: ${_formatBytes(metadata?.size ?? decryptedData.length)}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isSmallScreen ? 13 : 14,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatBytes(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }
}
