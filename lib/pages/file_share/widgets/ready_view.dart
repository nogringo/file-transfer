import 'package:file_transfer/controllers/file_share_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReadyView extends GetView<FileShareController> {
  const ReadyView({super.key});

  @override
  Widget build(BuildContext context) {
    final metadata = controller.metadata;
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
                Icons.file_download_rounded,
                size: isSmallScreen ? 56 : 72,
                color: colorScheme.primary,
              ),
              SizedBox(height: isSmallScreen ? 20 : 24),
              Text(
                'File Ready to Download',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isSmallScreen ? 16 : 18,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              if (metadata != null) ...[
                SizedBox(height: isSmallScreen ? 16 : 24),
                _buildMetadataCard(
                  context,
                  isSmallScreen,
                  metadata,
                  colorScheme,
                ),
              ],
              SizedBox(height: isSmallScreen ? 24 : 32),
              Obx(
                () => FilledButton.icon(
                  onPressed: controller.hasStarted
                      ? null
                      : controller.startDecrypt,
                  icon: controller.hasStarted
                      ? SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.download),
                  label: Text(
                    controller.hasStarted ? 'Downloading...' : 'Download',
                  ),
                ),
              ),
              if (controller.error != null) ...[
                SizedBox(height: isSmallScreen ? 12 : 16),
                _buildErrorBox(context, isSmallScreen, colorScheme),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetadataCard(
    BuildContext context,
    bool isSmallScreen,
    dynamic metadata,
    ColorScheme colorScheme,
  ) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (metadata.filename != null) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Name:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: isSmallScreen ? 13 : 14,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      metadata.filename!,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: isSmallScreen ? 13 : 14,
                        color: colorScheme.onSurfaceVariant,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const Divider(),
            ],
            if (metadata.fileType != null) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Type:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: isSmallScreen ? 13 : 14,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      metadata.fileType!,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: isSmallScreen ? 13 : 14,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(),
            ],
            if (metadata.size != null && metadata.size! > 0) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Size:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: isSmallScreen ? 13 : 14,
                    ),
                  ),
                  Text(
                    _formatBytes(metadata.size!),
                    style: TextStyle(
                      fontSize: isSmallScreen ? 13 : 14,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildErrorBox(
    BuildContext context,
    bool isSmallScreen,
    ColorScheme colorScheme,
  ) {
    return Container(
      padding: EdgeInsets.all(isSmallScreen ? 10 : 12),
      decoration: BoxDecoration(
        color: colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: colorScheme.onErrorContainer),
          SizedBox(width: isSmallScreen ? 8 : 12),
          Expanded(
            child: Text(
              controller.error!,
              style: TextStyle(
                color: colorScheme.onErrorContainer,
                fontSize: isSmallScreen ? 12 : 14,
              ),
            ),
          ),
        ],
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
