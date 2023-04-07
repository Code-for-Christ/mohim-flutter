import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phonebook/common/component/contact_card.dart';
import 'package:phonebook/common/const/colors.dart';
import 'package:phonebook/common/layout/default_layout.dart';
import 'package:phonebook/group/controller/group_controller.dart';
import 'package:phonebook/group/model/cell.dart';

class CellMembersScreen extends StatefulWidget {
  CellMembersScreen({super.key, required this.cell});
  final Cell cell;

  @override
  State<CellMembersScreen> createState() => _CellMembersScreenState();
}

class _CellMembersScreenState extends State<CellMembersScreen> {
  final groupCtrl = Get.find<GroupController>();

  @override
  void initState() {
    groupCtrl.getCellMembers(cellId: widget.cell.id);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    groupCtrl.cellMembers.value = [];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '${widget.cell.cell}구역',
      centerTitle: true,
      appBarColor: DETAIL_BG_COLOR,
      backgroudColor: DETAIL_BG_COLOR,
      child: Obx(() {
        return ListView.separated(
            padding: EdgeInsets.all(8),
            itemBuilder: ((context, index) {
              final member = groupCtrl.cellMembers[index];
              return ContactCard(member: member);
            }),
            separatorBuilder: ((context, index) {
              return Gap(12);
            }),
            itemCount: groupCtrl.cellMembers.length);
      }),
    );
  }
}
