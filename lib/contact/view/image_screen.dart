import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:phonebook/common/layout/default_layout.dart';
import 'package:phonebook/contact/controller/member_controller.dart';

class ImageScreen extends StatelessWidget {
  ImageScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '',
      foregroundColor: Colors.white,
      backgroudColor: Colors.black,
      appBarColor: Colors.black,
      child: Center(
        child: Obx(() {
          return Get.find<MemberController>().profileImageUrl.isNotEmpty
              ? InteractiveViewer(
                  child: Image.network(
                      Get.find<MemberController>().profileImageUrl.value))
              : Container();
        }),
      ),
    );
  }
}
