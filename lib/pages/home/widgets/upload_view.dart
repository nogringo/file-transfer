import 'package:file_transfer/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UploadView extends GetView<HomePageController> {
  const UploadView({super.key});

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('File Transfer')),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 16 : 24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: MediaQuery.of(context).padding.top),
                Icon(
                  Icons.upload_file_rounded,
                  size: isSmallScreen ? 64 : 80,
                  color: colorScheme.primary,
                ),
                SizedBox(height: isSmallScreen ? 20 : 24),
                Text(
                  'Select a file to share',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isSmallScreen ? 16 : 18,
                    color: colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: isSmallScreen ? 24 : 32),
                Obx(
                  () => FilledButton.icon(
                    onPressed: controller.isUploading
                        ? null
                        : controller.pickAndShareFile,
                    icon: controller.isUploading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.upload_file),
                    label: Text(
                      controller.isUploading ? 'Uploading...' : 'Select File',
                    ),
                  ),
                ),
                SizedBox(height: isSmallScreen ? 10 : 12),
                OutlinedButton.icon(
                  onPressed: controller.pasteAndOpenLink,
                  icon: const Icon(Icons.paste),
                  label: const Text('Paste Share Link'),
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
}
