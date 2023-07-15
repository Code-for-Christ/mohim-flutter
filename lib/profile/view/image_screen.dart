import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phonebook/common/const/colors.dart';
import 'package:phonebook/common/layout/default_layout.dart';
import 'package:phonebook/profile/controller/profile_controller.dart';
import 'package:phonebook/profile/util/cache_manager.dart';

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
                  ? CachedNetworkImage(
                      imageUrl: Get.find<ProfileController>().imageUrl.value,
                      errorWidget: (context, url, error) => Icon(
                        Icons.person,
                        size: 55,
                        color: PERSON_ICON_COLOR,
                      ),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      cacheManager: CustomCacheManager.instance,
                    )
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
