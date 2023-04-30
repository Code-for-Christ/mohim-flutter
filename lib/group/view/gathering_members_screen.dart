import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:phonebook/common/component/contact_card.dart';
import 'package:phonebook/common/const/colors.dart';
import 'package:phonebook/common/const/type.dart';
import 'package:phonebook/common/layout/default_layout.dart';
import 'package:phonebook/group/controller/group_controller.dart';
import 'package:phonebook/group/controller/pagination_controller.dart';
import 'package:phonebook/group/model/gathering.dart';

class GatheringMembersScreen extends StatefulWidget {
  const GatheringMembersScreen({super.key, required this.gathering});
  final Gathering gathering;

  @override
  State<GatheringMembersScreen> createState() => _GatheringMembersScreenState();
}

class _GatheringMembersScreenState extends State<GatheringMembersScreen> {
  final groupCtrl = Get.find<GroupController>();
  final scrollCtrl = ScrollController();
  late final PaginationController paginationCtrl;

  @override
  void initState() {
    // 콘트롤러 주입
    paginationCtrl = Get.put(PaginationController(
        scrollCtrl: scrollCtrl,
        type: GroupType.gathering,
        id: widget.gathering.id));

    groupCtrl.getGatheringMembers(gatheringId: widget.gathering.id);
    // indicator 표시 여부를 위한 초기화
    groupCtrl.nextData.value = false;

    super.initState();
  }

  @override
  void dispose() {
    groupCtrl.gatheringMembers.value = [];
    scrollCtrl.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: widget.gathering.name,
      centerTitle: true,
      appBarColor: DETAIL_BG_COLOR,
      backgroudColor: DETAIL_BG_COLOR,
      child: Obx(() {
        return groupCtrl.gatheringMembers.isNotEmpty
            ? ListView.separated(
                controller: scrollCtrl,
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                itemBuilder: ((context, index) {
                  if (index == groupCtrl.gatheringMembers.length) {
                    if (groupCtrl.nextData.value) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return Container();
                    }
                  }
                  final member = groupCtrl.gatheringMembers[index];
                  return ContactCard(member: member);
                }),
                separatorBuilder: ((context, index) {
                  return Gap(8);
                }),
                itemCount: groupCtrl.gatheringMembers.length + 1)
            : Container();
      }),
    );
  }
}
