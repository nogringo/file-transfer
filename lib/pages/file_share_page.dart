import 'package:file_transfer/pages/file_share/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_transfer/controllers/file_share_controller.dart';

class FileSharePage extends GetView<FileShareController> {
  const FileSharePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Download File')),
      body: GetBuilder<FileShareController>(
        builder: (controller) {
          if (controller.isFetchingMetadata) {
            return const LoadingView();
          } else if (controller.decryptedData != null) {
            return const SuccessView();
          } else {
            return ReadyView();
          }
        },
      ),
    );
  }
}
