import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phonebook/common/const/type.dart';
import 'package:phonebook/common/layout/default_layout.dart';
import 'package:phonebook/group/component/group_card.dart';
import 'package:phonebook/group/controller/group_controller.dart';

class PositionListScreen extends StatelessWidget {
  PositionListScreen({super.key});

  final GroupController groupCtrl = Get.find<GroupController>();

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: Obx(() {
        return ListView.separated(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            itemBuilder: (context, index) {
              final position = groupCtrl.positions[index];
              return GroupCard(
                groupData: position,
                icon: CupertinoIcons.group_solid,
                title: position.name,
                type: GroupType.position,
              );
            },
            separatorBuilder: (context, index) {
              return Gap(16);
            },
            itemCount: groupCtrl.positions.length);
      }),
    );
  }
}
