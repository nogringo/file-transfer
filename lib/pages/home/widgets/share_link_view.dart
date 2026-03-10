import 'package:file_transfer/controllers/home_controller.dart';
import 'package:file_transfer/l10n/app_localizations.dart';
import 'package:file_transfer/utils/platform_helper.dart';
import 'package:file_transfer_sdk/file_transfer_sdk.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShareLinkView extends GetView<HomePageController> {
  const ShareLinkView({super.key});

  @override
  Widget build(BuildContext context) {
    final sharedFile = controller.sharedFile!;
    final isSmallScreen = MediaQuery.of(context).size.width < 600;
    final colorScheme = Theme.of(context).colorScheme;
    final t = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(t.shareLinkReady),
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
                  Icons.check_circle_rounded,
                  size: isSmallScreen ? 64 : 80,
                  color: colorScheme.primary,
                ),
                SizedBox(height: isSmallScreen ? 20 : 24),
                Text(
                  t.fileReadyToShare,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isSmallScreen ? 16 : 18,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: isSmallScreen ? 16 : 24),
                _buildInfoCard(context, isSmallScreen, sharedFile, colorScheme),
                SizedBox(height: isSmallScreen ? 16 : 24),
                FilledButton.icon(
                  onPressed: controller.copyShareLink,
                  icon: const Icon(Icons.share),
                  label: Text(t.copyShareLink),
                ),
                SizedBox(height: isSmallScreen ? 6 : 8),
                OutlinedButton.icon(
                  onPressed: controller.reset,
                  icon: const Icon(Icons.add),
                  label: Text(t.shareAnotherFile),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context,
    bool isSmallScreen,
    SharedFile sharedFile,
    ColorScheme colorScheme,
  ) {
    final t = AppLocalizations.of(context);
    final shareLink = PlatformHelper.buildShareLink(
      sharedFile.nevent,
      sharedFile.encodedPrivateKey,
    );

    return Card(
      child: Padding(
        padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow(t.shareLink, shareLink, isSmallScreen, colorScheme),
            SizedBox(height: isSmallScreen ? 12 : 16),
            _buildInfoRow(
              t.eventNevent,
              sharedFile.nevent,
              isSmallScreen,
              colorScheme,
            ),
            SizedBox(height: isSmallScreen ? 12 : 16),
            _buildInfoRow(
              t.privateKeyNsec,
              sharedFile.encodedPrivateKey,
              isSmallScreen,
              colorScheme,
            ),
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
}
