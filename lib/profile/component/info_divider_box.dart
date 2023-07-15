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
    required this.icon,
  });

  final String title;
  final String subTitle;
  final IconData icon;

  renderMinistries() {
    if (title != '봉사') {
      return subTitle;
    }

    String joinedString = Get.find<ProfileController>()
        .ministryRoles
        .map((e) => '${e.ministryName}(${e.ministryRole})')
        .join(', ');

    return joinedString;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: PRIMARY_COLOR,
            ),
            Gap(16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: body2TextStyle.copyWith(
                      color: BODY_TEXT_COLOR,
                      fontWeight: FontWeight.w500,
                      fontSize: 18),
                ),
                Gap(8),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 4 * 3,
                  child: Text(
                    renderMinistries(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: body1TextStyle.copyWith(
                        color: Colors.black, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ],
        ),
        Divider(
          color: INPUT_BG_COLOR,
          thickness: 1,
          height: 30,
        ),
      ],
    );
  }
}
