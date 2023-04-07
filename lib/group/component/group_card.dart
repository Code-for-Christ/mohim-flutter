import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phonebook/common/const/colors.dart';
import 'package:phonebook/common/const/style.dart';
import 'package:phonebook/common/const/type.dart';
import 'package:phonebook/group/view/cell_list_screen.dart';
import 'package:phonebook/group/view/gathering_members_screen.dart';
import 'package:phonebook/group/view/ministry_members_screen.dart';

class GroupCard extends StatelessWidget {
  const GroupCard({
    super.key,
    required this.icon,
    required this.title,
    this.subtitleData,
    required this.type,
    this.groupData,
  });
  final IconData icon;
  final dynamic subtitleData;
  final String title;
  final GroupType type;
  final dynamic groupData;

  renderSubtitle() {
    if (type == GroupType.cell) {
      List cells = subtitleData.map((data) => data.cell).toList();
      return '${cells.join(', ')}구역';
    }
    return '';
  }

  renderTitle() {
    if (type == GroupType.cell) {
      return title;
    }
    if (type == GroupType.ministry) {
      if (title == '청년회') {
        return '청년회임원';
      }
      if (title == '구역') {
        return '구역임원';
      }
      if (title == '교구') {
        return '교구임원';
      }
      return title;
    }
    if (type == GroupType.gathering) {
      return title;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (type == GroupType.cell) {
          Get.to(
              CellListScreen(
                parish: int.parse(title[0]),
                cells: subtitleData,
              ),
              transition: Transition.cupertino);
        }
        if (type == GroupType.ministry) {
          Get.to(
              MinistryMembersScreen(
                ministry: groupData,
              ),
              transition: Transition.cupertino);
        }
        if (type == GroupType.gathering) {
          Get.to(GatheringMembersScreen(gathering: groupData),
              transition: Transition.cupertino);
        }
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
                    renderTitle(),
                    style: body1TextStyle.copyWith(fontSize: 22),
                  ),
                  Gap(4),
                  subtitleData != null
                      ? Text(
                          renderSubtitle(),
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
