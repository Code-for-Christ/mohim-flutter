import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:phonebook/common/const/type.dart';
import 'package:phonebook/common/layout/default_layout.dart';
import 'package:phonebook/group/component/group_card.dart';
import 'package:phonebook/group/controller/group_controller.dart';

class MinistryScreen extends StatelessWidget {
  MinistryScreen({super.key});

  final groupCtrl = Get.put(GroupController());

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: Obx(() {
        return ListView.separated(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            itemBuilder: ((context, index) {
              final ministry = groupCtrl.ministries[index];
              return GroupCard(
                icon: CupertinoIcons.group_solid,
                title: ministry.name,
                type: GroupType.ministry,
                groupData: ministry,
              );
            }),
            separatorBuilder: ((context, index) {
              return Gap(16);
            }),
            itemCount: groupCtrl.ministries.length);
      }),
    );
  }
}
