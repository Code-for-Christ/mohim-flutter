import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/instance_manager.dart';
import 'package:phonebook/common/const/type.dart';
import 'package:phonebook/common/layout/default_layout.dart';
import 'package:phonebook/group/component/group_card.dart';
import 'package:phonebook/group/controller/group_controller.dart';

class GatheringListScreen extends StatelessWidget {
  GatheringListScreen({super.key});

  final groupCtrl = Get.find<GroupController>();

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        child: ListView.separated(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            itemBuilder: ((context, index) {
              final gathering = groupCtrl.gatherings[index];
              return GroupCard(
                icon: CupertinoIcons.group_solid,
                title: gathering.name,
                type: GroupType.gathering,
                groupData: gathering,
              );
            }),
            separatorBuilder: ((context, index) {
              return Gap(16);
            }),
            itemCount: groupCtrl.gatherings.length));
  }
}
