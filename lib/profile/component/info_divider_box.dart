import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phonebook/common/const/colors.dart';
import 'package:phonebook/common/const/style.dart';
import 'package:phonebook/profile/controller/profile_controller.dart';

class InfoDividerBox extends StatelessWidget {
  InfoDividerBox({
    super.key,
    required this.title,
    required this.subTitle,
    this.icon = Icons.circle,
    this.showDivider = true,
  });

  final String title;
  final String subTitle;
  final IconData icon;
  final bool showDivider;

  renderMinistries() {
    if (title != '봉사') {
      return subTitle;
    }

    // String joinedString = Get.find<ProfileController>()
    //     .member
    //     .value
    //     .ministries
    //     .map((e) => '${e.name}(${e.role})')
    //     .join(', ');

    String joinedString = Get.find<ProfileController>()
        .member
        .value
        .ministries
        .map((e) => e.role != null ? '${e.name}(${e.role})' : e.name)
        .join('\n');

    return joinedString;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Icon(
                  icon,
                  color: PRIMARY_COLOR,
                  size: 10,
                ),
              ),
              Gap(12),
              Text(
                title,
                style: body2TextStyle.copyWith(
                    color: BODY_TEXT_COLOR,
                    fontWeight: FontWeight.w500,
                    fontSize: 18),
              ),
              Spacer(),
              SingleChildScrollView(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 1.8,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      renderMinistries(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: body1TextStyle.copyWith(
                          color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(
          color: showDivider ? INPUT_BG_COLOR : Colors.white,
          thickness: 1,
          height: 30,
        ),
      ],
    );
  }
}
