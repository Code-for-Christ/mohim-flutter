import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phonebook/common/component/empty_leader_card.dart';
import 'package:phonebook/common/component/leader_card.dart';
import 'package:phonebook/common/const/colors.dart';
import 'package:phonebook/common/const/style.dart';
import 'package:phonebook/common/layout/default_layout.dart';
import 'package:phonebook/group/component/list_card.dart';
import 'package:phonebook/group/controller/group_controller.dart';
import 'package:phonebook/group/model/cell.dart';
import 'package:phonebook/group/view/cell_members_screen.dart';

class CellListScreen extends StatefulWidget {
  const CellListScreen({super.key, required this.parish, required this.cells});
  final int parish;
  final List<Cell> cells;

  @override
  State<CellListScreen> createState() => _CellListScreenState();
}

class _CellListScreenState extends State<CellListScreen> {
  final groupCtrl = Get.find<GroupController>();

  @override
  void initState() {
    super.initState();
    getParishLeader();
  }

  getParishLeader() {
    groupCtrl.getParishLeaders(parish: widget.parish);
  }

  @override
  void dispose() {
    super.dispose();
    groupCtrl.parishLeaders.value = [];
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '${widget.parish}교구',
      centerTitle: true,
      appBarColor: DETAIL_BG_COLOR,
      backgroudColor: DETAIL_BG_COLOR,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '교구임원',
                style: body1TextStyle,
              ),
              Gap(8),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 150,
                child: Obx(() {
                  return groupCtrl.parishLeaders.isNotEmpty
                      ? ListView.separated(
                          // 성공적으로 데이터를 불러올 경우
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final leader = groupCtrl.parishLeaders[index];
                            return LeaderCard(
                              leader: leader,
                              name: leader.name,
                              role: leader.parishRole!,
                              thumbnail: leader.thumbnail!,
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Gap(8);
                          },
                          itemCount: groupCtrl.parishLeaders.length)
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
                          itemCount: 2);
                }),
              ),
              Gap(16),
              Text(
                '구역목록',
                style: body1TextStyle,
              ),
              Gap(8),
              ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: ((context, index) {
                    final cell = widget.cells[index];
                    return ListCard(
                      cell: '${cell.cell}구역',
                      onTap: () => Get.to(CellMembersScreen(cell: cell),
                          transition: Transition.cupertino),
                    );
                  }),
                  separatorBuilder: ((context, index) {
                    return Gap(16);
                  }),
                  itemCount: widget.cells.length),
            ],
          ),
        ),
      ),
    );
  }
}
