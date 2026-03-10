import 'package:file_transfer/l10n/app_localizations.dart';
import 'package:file_transfer/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ndk_flutter/ndk_flutter.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  void _navigateBack(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      Get.offAllNamed(AppRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ndkFlutter = Get.find<NdkFlutter>();
    final t = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(t.connectToNostr),
        leading: IconButton(
          icon: const BackButtonIcon(),
          onPressed: () => _navigateBack(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: NLogin(
              ndkFlutter: ndkFlutter,
              enablePubkeyLogin: false,
              onLoggedIn: () => _navigateBack(context),
            ),
          ),
        ),
      ),
    );
  }
}
