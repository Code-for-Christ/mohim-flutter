import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phonebook/common/component/contact_card.dart';
import 'package:phonebook/common/component/empty_leader_card.dart';
import 'package:phonebook/common/component/leader_card.dart';
import 'package:phonebook/common/const/colors.dart';
import 'package:phonebook/common/const/style.dart';
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
    groupCtrl.getCellLeaders(cellId: widget.cell.id);
    // indicator 표시 여부를 위한 초기화
    groupCtrl.nextData.value = false;
    super.initState();
  }

  @override
  void dispose() {
    groupCtrl.cellMembers.value = [];
    groupCtrl.cellLeaders.value = [];
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
      child: SingleChildScrollView(
        controller: scrollCtrl,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '구역임원',
                style: body1TextStyle,
              ),
              Gap(8),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 150,
                child: Obx(() {
                  return groupCtrl.cellLeaders.isNotEmpty
                      ? ListView.separated(
                          // 성공적으로 데이터를 불러올 경우
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final leader = groupCtrl.cellLeaders[index];
                            return LeaderCard(
                              leader: leader,
                              name: leader.name,
                              role: leader.cellRole!,
                              thumbnail: leader.thumbnail,
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Gap(8);
                          },
                          itemCount: groupCtrl.cellLeaders.length)
                      : ListView.separated(
                          // 데이터가 비어있거나 로드에 실패한 경우
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return EmptyLeaderCard();
                          },
                          separatorBuilder: (context, index) {
                            return Gap(8);
                          },
                          itemCount: 4);
                }),
              ),
              Gap(16),
              Text(
                '구역명단',
                style: body1TextStyle,
              ),
              Gap(8),
              Obx(() {
                return ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
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
                      final nextHouseholderId =
                          index + 1 < groupCtrl.cellMembers.length
                              ? groupCtrl.cellMembers[index + 1].householderId
                              : null;
                      return currentHouseholderId == nextHouseholderId
                          ? Gap(8) // 같은 householder_id 끼리는 여백만 주기
                          : Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: Container(
                                width: double.infinity,
                                height: 4,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[300]),
                              ),
                            );
                    }),
                    itemCount: groupCtrl.cellMembers.length + 1);
              }),
            ],
          ),
        ),
      ),
    );
  }
}
