import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phonebook/common/component/contact_card.dart';
import 'package:phonebook/common/const/colors.dart';
import 'package:phonebook/common/const/type.dart';
import 'package:phonebook/common/layout/default_layout.dart';
import 'package:phonebook/group/controller/group_controller.dart';
import 'package:phonebook/group/controller/pagination_controller.dart';
import 'package:phonebook/group/model/cell.dart';

class CellMembersScreen extends StatefulWidget {
  CellMembersScreen({super.key, required this.cell});
  final Cell cell;

  @override
  State<CellMembersScreen> createState() => _CellMembersScreenState();
}

class _CellMembersScreenState extends State<CellMembersScreen> {
  final groupCtrl = Get.find<GroupController>();
  final scrollCtrl = ScrollController();
  late final PaginationController paginationCtrl;

  @override
  void initState() {
    // 콘트롤러 주입
    paginationCtrl = Get.put(PaginationController(
        scrollCtrl: scrollCtrl, type: GroupType.cell, id: widget.cell.id));
    groupCtrl.getCellMembers(cellId: widget.cell.id);
    // indicator 표시 여부를 위한 초기화
    groupCtrl.nextData.value = false;
    super.initState();
  }

  @override
  void dispose() {
    groupCtrl.cellMembers.value = [];
    // 스크롤 컨트롤러 해제
    scrollCtrl.dispose();
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
            controller: scrollCtrl,
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            itemBuilder: ((context, index) {
              if (index == groupCtrl.cellMembers.length) {
                if (groupCtrl.nextData.value) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return Container(); // 빈 컨테이너 반환
                }
              }
              final member = groupCtrl.cellMembers[index];
              return ContactCard(member: member);
            }),
            separatorBuilder: ((context, index) {
              return Gap(12);
            }),
            itemCount: groupCtrl.cellMembers.length + 1);
      }),
    );
  }
}
