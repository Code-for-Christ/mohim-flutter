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
  late int preHouseholderId;

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
              preHouseholderId = member.householderId;
              return ContactCard(member: member);
            }),
            separatorBuilder: ((context, index) {
              if (index == groupCtrl.cellMembers.length - 1) {
                return Gap(8);
              }
              final currentHouseholderId =
                  groupCtrl.cellMembers[index].householderId;
              final nextHouseholderId = index + 1 < groupCtrl.cellMembers.length
                  ? groupCtrl.cellMembers[index + 1].householderId
                  : null;
              return currentHouseholderId == nextHouseholderId
                  ? Gap(8) // 같은 householder_id 끼리는 여백만 주기
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 12),
                      child: Container(
                        width: double.infinity,
                        height: 4,
                        // decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(10),
                        //     color: Colors.grey),
                      ),
                    );
              // Divider(

              //     color: BODY_TEXT_COLOR,
              //     thickness: 2,
              //     height: 30,
              //   ); // 아닌 경우는 Divider 추가
            }),
            itemCount: groupCtrl.cellMembers.length + 1);
      }),
    );
  }
}
