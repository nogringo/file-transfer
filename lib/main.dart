import 'package:file_transfer/controllers/file_share_controller.dart';
import 'package:file_transfer/controllers/home_controller.dart';
import 'package:file_transfer/pages/file_share_page.dart';
import 'package:file_transfer/pages/home_page.dart';
import 'package:file_transfer/routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ndk/ndk.dart';
import 'package:ndk_flutter/ndk_flutter.dart';
import 'package:toastification/toastification.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final ndk = Ndk(
    NdkConfig(
      eventVerifier: kIsWeb ? WebEventVerifier() : Bip340EventVerifier(),
      cache: MemCacheManager(),
    ),
  );

  Get.put(ndk);

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: GetMaterialApp(
        title: 'File Transfer',
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        getPages: [
          GetPage(
            name: AppRoutes.home,
            page: () => const HomePage(),
            binding: BindingsBuilder(() {
              Get.put(HomePageController());
            }),
          ),
          GetPage(
            name: AppRoutes.fileShare,
            page: () => const FileSharePage(),
            binding: BindingsBuilder(() {
              Get.put(FileShareController());
            }),
          ),
        ],
      ),
    );
  }
}
