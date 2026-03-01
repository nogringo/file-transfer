import 'package:file_transfer/controllers/home_controller.dart';
import 'package:file_transfer/models/file_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FileInfoView extends GetView<HomePageController> {
  const FileInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    final fileInfo = controller.fileInfo;
    final isSmallScreen = MediaQuery.of(context).size.width < 600;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('File Ready to Upload'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: controller.reset,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 16 : 24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: MediaQuery.of(context).padding.top),
                Icon(
                  Icons.insert_drive_file_rounded,
                  size: isSmallScreen ? 64 : 80,
                  color: colorScheme.primary,
                ),
                SizedBox(height: isSmallScreen ? 20 : 24),
                Text(
                  'File selected',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isSmallScreen ? 16 : 18,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: isSmallScreen ? 16 : 24),
                _buildFileInfoCard(
                  context,
                  isSmallScreen,
                  fileInfo!,
                  colorScheme,
                ),
                SizedBox(height: isSmallScreen ? 24 : 32),
                Obx(
                  () => FilledButton.icon(
                    onPressed: controller.isUploading
                        ? null
                        : () => controller.startUpload(),
                    icon: controller.isUploading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.cloud_upload),
                    label: Text(
                      controller.isUploading ? 'Uploading...' : 'Upload File',
                    ),
                  ),
                ),
                SizedBox(height: isSmallScreen ? 6 : 8),
                OutlinedButton.icon(
                  onPressed: controller.reset,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Select Different File'),
                ),
                Obx(() {
                  if (controller.error != null) {
                    return _buildErrorBox(context, isSmallScreen, colorScheme);
                  }
                  return const SizedBox.shrink();
                }),
              ],
            ),
          ),
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

  Widget _buildFileInfoCard(
    BuildContext context,
    bool isSmallScreen,
    FileInfo fileInfo,
    ColorScheme colorScheme,
  ) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow('Name:', fileInfo.name, isSmallScreen, colorScheme),
            SizedBox(height: isSmallScreen ? 12 : 16),
            _buildInfoRow(
              'Size:',
              _formatFileSize(fileInfo.size),
              isSmallScreen,
              colorScheme,
            ),
            SizedBox(height: isSmallScreen ? 12 : 16),
            _buildInfoRow(
              'Type:',
              fileInfo.mimeType ?? 'Unknown',
              isSmallScreen,
              colorScheme,
            ),
            if (fileInfo.lastModified != null) ...[
              SizedBox(height: isSmallScreen ? 12 : 16),
              _buildInfoRow(
                'Modified:',
                _formatDate(fileInfo.lastModified!),
                isSmallScreen,
                colorScheme,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    String label,
    String value,
    bool isSmallScreen,
    ColorScheme colorScheme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: isSmallScreen ? 13 : 14,
          ),
        ),
        SizedBox(height: isSmallScreen ? 6 : 8),
        Text(
          value,
          style: TextStyle(
            fontSize: isSmallScreen ? 11 : 12,
            fontFamily: 'monospace',
            color: colorScheme.onSurfaceVariant,
          ),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} '
        '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}:${date.second.toString().padLeft(2, '0')}';
  }
}
