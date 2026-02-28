import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ndk/ndk.dart';
import 'package:ndk_flutter/ndk_flutter.dart';

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
    return GetMaterialApp(
      home: Scaffold(
        body: Center(
          child: FilledButton(
            onPressed: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles();

              if (result == null) return;
              

            },
            child: Text("data"),
          ),
        ),
      ),
    );
  }
}
