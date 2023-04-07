import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phonebook/common/const/colors.dart';
import 'package:phonebook/common/const/type.dart';
import 'package:phonebook/common/layout/default_layout.dart';
import 'package:phonebook/group/component/group_card.dart';
import 'package:phonebook/group/controller/group_controller.dart';

class ParishListScreen extends StatelessWidget {
  ParishListScreen({super.key});

  final groupCtrl = Get.find<GroupController>();

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(child: Obx(() {
      return groupCtrl.parishes.isNotEmpty && groupCtrl.cells.isNotEmpty
          ? ListView.separated(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              itemBuilder: ((context, index) {
                final parish = groupCtrl.parishes[index];
                final cells = groupCtrl.cells
                    .where((cell) => cell.parish == parish)
                    .toList();
                return GroupCard(
                  icon: CupertinoIcons.group_solid,
                  title: '$parish교구',
                  subtitleData: cells,
                  type: GroupType.cell,
                );
              }),
              separatorBuilder: ((context, index) {
                return Gap(16);
              }),
              itemCount: groupCtrl.parishes.length)
          : Center(
              child: CircularProgressIndicator(
                color: PRIMARY_COLOR,
              ),
            );
    }));
  }
}
