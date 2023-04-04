import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phonebook/common/const/colors.dart';
import 'package:phonebook/common/const/style.dart';
import 'package:phonebook/common/const/type.dart';
import 'package:phonebook/group/view/cell_list_screen.dart';

class GroupCard extends StatelessWidget {
  const GroupCard(
      {super.key,
      required this.icon,
      required this.title,
      this.subtitle,
      required this.type});
  final IconData icon;
  final String? subtitle;
  final String title;
  final GroupType type;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (type == GroupType.cell) {
          Get.to(CellListScreen(parish: int.parse(title[0])));
        }
        if (type == GroupType.ministry) {}
        if (type == GroupType.gathering) {}
      },
      child: Container(
        width: double.infinity,
        height: 80,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: INPUT_BG_COLOR),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 30,
                color: PRIMARY_COLOR,
              ),
              Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    title,
                    style: body1TextStyle.copyWith(fontSize: 22),
                  ),
                  Gap(4),
                  subtitle != null
                      ? Text(
                          subtitle!,
                          style: body2TextStyle,
                        )
                      : Container()
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
