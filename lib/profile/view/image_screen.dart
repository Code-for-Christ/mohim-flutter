import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phonebook/common/const/colors.dart';
import 'package:phonebook/common/layout/default_layout.dart';
import 'package:phonebook/contact/controller/member_controller.dart';
import 'package:phonebook/profile/controller/profile_controller.dart';

class ImageScreen extends StatelessWidget {
  ImageScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragEnd: (details) => Get.back(),
      child: DefaultLayout(
        title: '',
        foregroundColor: Colors.white,
        backgroudColor: Colors.black,
        appBarColor: Colors.black,
        child: SafeArea(
          child: Center(
            child: Obx(() {
              return Get.find<ProfileController>().imageUrl.isNotEmpty
                  ? InteractiveViewer(
                      child: Image.network(
                          Get.find<ProfileController>().imageUrl.value))
                  : Center(
                      child: Icon(
                        Icons.person,
                        color: PERSON_ICON_COLOR,
                        size: MediaQuery.of(context).size.width / 3,
                      ),
                    );
            }),
          ),
        ),
      ),
    );
  }
}
