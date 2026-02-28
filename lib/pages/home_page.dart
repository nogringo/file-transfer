import 'package:file_transfer/pages/home/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_transfer/controllers/home_controller.dart';

class HomePage extends GetView<HomePageController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.sharedFile != null) {
        return const ShareLinkView();
      }
      return const UploadView();
    });
  }
}
