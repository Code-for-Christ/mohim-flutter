import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:phonebook/common/component/contact_card.dart';
import 'package:phonebook/common/const/colors.dart';
import 'package:phonebook/common/layout/default_layout.dart';
import 'package:phonebook/group/controller/group_controller.dart';
import 'package:phonebook/group/model/gathering.dart';

class GatheringMembersScreen extends StatefulWidget {
  const GatheringMembersScreen({super.key, required this.gathering});
  final Gathering gathering;

  @override
  State<GatheringMembersScreen> createState() => _GatheringMembersScreenState();
}

class _GatheringMembersScreenState extends State<GatheringMembersScreen> {
  final groupCtrl = Get.find<GroupController>();

  @override
  void initState() {
    groupCtrl.getGatheringMembers(gatheringId: widget.gathering.id);
    super.initState();
  }

  @override
  void dispose() {
    groupCtrl.gatheringMembers.value = [];
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
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                itemBuilder: ((context, index) {
                  final member = groupCtrl.gatheringMembers[index];
                  print(member);
                  return ContactCard(member: member);
                }),
                separatorBuilder: ((context, index) {
                  return Gap(16);
                }),
                itemCount: groupCtrl.gatheringMembers.length)
            : Container();
      }),
    );
  }
}
