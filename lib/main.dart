import 'package:file_transfer/constants.dart';
import 'package:file_transfer/controllers/account_controller.dart';
import 'package:file_transfer/controllers/file_share_controller.dart';
import 'package:file_transfer/controllers/home_controller.dart';
import 'package:file_transfer/l10n/app_localizations.dart';
import 'package:file_transfer/pages/file_share_page.dart';
import 'package:file_transfer/pages/home_page.dart';
import 'package:file_transfer/pages/login_page.dart';
import 'package:file_transfer/routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:ndk/ndk.dart';
import 'package:ndk/shared/nips/nip01/bip340.dart';
import 'package:ndk_flutter/ndk_flutter.dart';
import 'package:ndk_flutter/l10n/app_localizations.dart' as ndk_flutter;
import 'package:system_theme/system_theme.dart';
import 'package:toastification/toastification.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemTheme.fallbackColor = Colors.deepPurpleAccent;
  await SystemTheme.accentColor.load();

  final ndk = Ndk(
    NdkConfig(
      eventVerifier: kIsWeb ? WebEventVerifier() : Bip340EventVerifier(),
      cache: MemCacheManager(),
    ),
  );
  Get.put(ndk);

  final ndkFlutter = NdkFlutter(ndk: ndk);
  Get.put(ndkFlutter);

  await ndkFlutter.restoreAccountsState();

  final prefs = await SharedPreferences.getInstance();

  if (ndk.accounts.accounts.isEmpty) {
    // First time: create anonymous account
    final keyPair = Bip340.generatePrivateKey();
    ndk.accounts.loginPrivateKey(
      pubkey: keyPair.publicKey,
      privkey: keyPair.privateKey!,
    );
    await ndkFlutter.saveAccountsState();
    await prefs.setString(anonymousPubkeyKey, keyPair.publicKey);
  }

  // Initialize AccountController after NDK is set up
  Get.put(AccountController());

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: GetMaterialApp(
        onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
        theme: ThemeData.from(
          colorScheme: ColorScheme.fromSeed(
            seedColor: SystemTheme.accentColor.accent,
            brightness: Brightness.light,
          ),
        ),
        darkTheme: ThemeData.from(
          colorScheme: ColorScheme.fromSeed(
            seedColor: SystemTheme.accentColor.accent,
            brightness: Brightness.dark,
          ),
        ),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          AppLocalizations.delegate,
          ndk_flutter.AppLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        getPages: [
          GetPage(
            name: AppRoutes.home,
            page: () => const HomePage(),
            binding: BindingsBuilder(() {
              Get.put(HomePageController());
            }),
          ),
          GetPage(name: AppRoutes.login, page: () => const LoginPage()),
          GetPage(
            name: AppRoutes.fileShare,
            page: () => const FileSharePage(),
            binding: BindingsBuilder(() {
              Get.put(FileShareController());
            }),
          ),
        ],
        locale: kDebugMode ? Locale("fr") : null,
      ),
    );
  }
}
