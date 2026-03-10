import 'package:desktop_drop/desktop_drop.dart';
import 'package:file_transfer/controllers/account_controller.dart';
import 'package:file_transfer/controllers/home_controller.dart';
import 'package:file_transfer/routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:file_transfer/l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:ndk/ndk.dart';
import 'package:ndk_flutter/ndk_flutter.dart';

class UploadView extends GetView<HomePageController> {
  const UploadView({super.key});

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;
    final colorScheme = Theme.of(context).colorScheme;
    final accountController = Get.find<AccountController>();
    final ndkFlutter = Get.find<NdkFlutter>();
    final ndk = Get.find<Ndk>();
    final t = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(t.appTitle),
        actions: [
          GetBuilder<AccountController>(
            builder: (_) {
              if (accountController.isLoading) {
                return const SizedBox.shrink();
              }
              if (!accountController.hasRealAccount) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: TextButton.icon(
                    onPressed: () => Get.toNamed(AppRoutes.login),
                    icon: const Icon(Icons.login),
                    label: Text(t.login),
                  ),
                );
              }
              final pubkey = accountController.pubkey;
              if (pubkey == null) {
                return const SizedBox.shrink();
              }
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: GestureDetector(
                  onTap: () {
                    final accounts = ndk.accounts.accounts.values;
                    final currentPubkey = ndk.accounts
                        .getLoggedAccount()
                        ?.pubkey;

                    if (isSmallScreen) {
                      showModalBottomSheet<String>(
                        context: context,
                        showDragHandle: true,
                        builder: (ctx) => Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            for (final account in accounts)
                              ListTile(
                                leading: SizedBox(
                                  width: 32,
                                  height: 32,
                                  child: account.pubkey == currentPubkey
                                      ? Stack(
                                          children: [
                                            NPicture(
                                              ndkFlutter: ndkFlutter,
                                              pubkey: account.pubkey,
                                            ),
                                            Positioned(
                                              bottom: 0,
                                              right: 0,
                                              child: Container(
                                                width: 10,
                                                height: 10,
                                                decoration: BoxDecoration(
                                                  color: colorScheme.primary,
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    color: colorScheme.surface,
                                                    width: 1,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      : NPicture(
                                          ndkFlutter: ndkFlutter,
                                          pubkey: account.pubkey,
                                        ),
                                ),
                                title:
                                    account.pubkey ==
                                        accountController.anonymousPubkey
                                    ? Text(t.anonymous)
                                    : NName(
                                        ndkFlutter: ndkFlutter,
                                        pubkey: account.pubkey,
                                        style: TextStyle(
                                          fontWeight:
                                              account.pubkey == currentPubkey
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                subtitle: account.pubkey == currentPubkey
                                    ? Text(t.current)
                                    : null,
                                onTap: () {
                                  Navigator.pop(ctx);
                                  accountController.handleSwitchAccount(
                                    account.pubkey,
                                  );
                                },
                              ),
                            const SizedBox(height: 8),
                            const Divider(),
                            ListTile(
                              leading: const Icon(Icons.add_circle_outline),
                              title: Text(t.addAccount),
                              onTap: () {
                                Navigator.pop(ctx);
                                Get.toNamed(AppRoutes.login);
                              },
                            ),
                            ListTile(
                              leading: Icon(
                                Icons.logout,
                                color: colorScheme.error,
                              ),
                              title: Text(
                                t.logout,
                                style: TextStyle(color: colorScheme.error),
                              ),
                              onTap: () {
                                Navigator.pop(ctx);
                                accountController.handleLogout();
                              },
                            ),
                          ],
                        ),
                      );
                    } else {
                      showMenu<String>(
                        context: context,
                        position: RelativeRect.fromLTRB(
                          MediaQuery.of(context).size.width,
                          0,
                          0,
                          0,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(
                            color: colorScheme.outlineVariant,
                            width: 1,
                          ),
                        ),
                        items: [
                          for (final account in accounts)
                            PopupMenuItem<String>(
                              value: 'switch_${account.pubkey}',
                              child: ListTile(
                                leading: SizedBox(
                                  width: 32,
                                  height: 32,
                                  child: account.pubkey == currentPubkey
                                      ? Stack(
                                          children: [
                                            NPicture(
                                              ndkFlutter: ndkFlutter,
                                              pubkey: account.pubkey,
                                            ),
                                            Positioned(
                                              bottom: 0,
                                              right: 0,
                                              child: Container(
                                                width: 10,
                                                height: 10,
                                                decoration: BoxDecoration(
                                                  color: colorScheme.primary,
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    color: colorScheme.surface,
                                                    width: 1,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      : NPicture(
                                          ndkFlutter: ndkFlutter,
                                          pubkey: account.pubkey,
                                        ),
                                ),
                                title:
                                    account.pubkey ==
                                        accountController.anonymousPubkey
                                    ? Text(t.anonymous)
                                    : NName(
                                        ndkFlutter: ndkFlutter,
                                        pubkey: account.pubkey,
                                        style: TextStyle(
                                          fontWeight:
                                              account.pubkey == currentPubkey
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                subtitle: account.pubkey == currentPubkey
                                    ? Text(t.current)
                                    : null,
                                contentPadding: EdgeInsets.zero,
                                visualDensity: VisualDensity.compact,
                              ),
                            ),
                          const PopupMenuDivider(),
                          PopupMenuItem(
                            value: 'add_account',
                            child: ListTile(
                              leading: Icon(Icons.add_circle_outline),
                              title: Text(t.addAccount),
                              contentPadding: EdgeInsets.zero,
                              visualDensity: VisualDensity.compact,
                            ),
                          ),
                          PopupMenuItem(
                            value: 'logout',
                            child: ListTile(
                              leading: Icon(
                                Icons.logout,
                                color: colorScheme.error,
                              ),
                              title: Text(
                                t.logout,
                                style: TextStyle(color: colorScheme.error),
                              ),
                              contentPadding: EdgeInsets.zero,
                              visualDensity: VisualDensity.compact,
                            ),
                          ),
                        ],
                      ).then(accountController.handleMenuSelection);
                    }
                  },
                  child: NPicture(ndkFlutter: ndkFlutter),
                ),
              );
            },
          ),
        ],
      ),
      body: kIsWeb
          ? _buildWebDropzone(context, isSmallScreen, colorScheme)
          : _buildDesktopDropzone(context, isSmallScreen, colorScheme),
    );
  }

  Widget _buildWebDropzone(
    BuildContext context,
    bool isSmallScreen,
    ColorScheme colorScheme,
  ) {
    final t = AppLocalizations.of(context);
    return Stack(
      children: [
        Obx(
          () => IgnorePointer(
            ignoring: !controller.isDragging,
            child: Container(
              color: controller.isDragging
                  ? colorScheme.primary.withValues(alpha: 0.1)
                  : Colors.transparent,
              child: Center(
                child: controller.isDragging
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.file_download_rounded,
                            size: 80,
                            color: colorScheme.primary,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            t.dropFileToUpload,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: colorScheme.primary,
                            ),
                          ),
                        ],
                      )
                    : null,
              ),
            ),
          ),
        ),
        DropzoneView(
          operation: DragOperation.copy,
          cursor: CursorType.grab,
          onCreated: (DropzoneViewController ctrl) {
            controller.dropzoneController.value = ctrl;
          },
          onHover: () {
            controller.onDragHover();
          },
          onLeave: () {
            controller.onDragLeave();
          },
          onDropFile: (DropzoneFileInterface file) {
            controller.handleDroppedFile(file);
          },
        ),
        _buildContent(context, isSmallScreen, colorScheme),
      ],
    );
  }

  Widget _buildDesktopDropzone(
    BuildContext context,
    bool isSmallScreen,
    ColorScheme colorScheme,
  ) {
    final t = AppLocalizations.of(context);
    return DropTarget(
      onDragDone: (event) {
        if (event.files.isNotEmpty) {
          controller.handleDroppedFile(event.files.first.path);
        }
      },
      onDragEntered: (event) {
        controller.onDragHover();
      },
      onDragExited: (event) {
        controller.onDragLeave();
      },
      child: Stack(
        children: [
          Obx(
            () => IgnorePointer(
              ignoring: !controller.isDragging,
              child: Container(
                color: controller.isDragging
                    ? colorScheme.primary.withValues(alpha: 0.1)
                    : Colors.transparent,
                child: Center(
                  child: controller.isDragging
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.file_download_rounded,
                              size: 80,
                              color: colorScheme.primary,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              t.dropFileToUpload,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: colorScheme.primary,
                              ),
                            ),
                          ],
                        )
                      : null,
                ),
              ),
            ),
          ),
          _buildContent(context, isSmallScreen, colorScheme),
        ],
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    bool isSmallScreen,
    ColorScheme colorScheme,
  ) {
    final t = AppLocalizations.of(context);
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
                Icons.upload_file_rounded,
                size: isSmallScreen ? 64 : 80,
                color: colorScheme.primary,
              ),
              SizedBox(height: isSmallScreen ? 20 : 24),
              Text(
                t.dragDropFile,
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
                    controller.isUploading ? t.uploading : t.selectFile,
                  ),
                ),
              ),
              SizedBox(height: isSmallScreen ? 10 : 12),
              OutlinedButton.icon(
                onPressed: controller.pasteAndOpenLink,
                icon: const Icon(Icons.paste),
                label: Text(t.pasteShareLink),
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
