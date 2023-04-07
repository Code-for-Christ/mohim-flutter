import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:phonebook/common/component/contact_card.dart';
import 'package:phonebook/common/const/colors.dart';
import 'package:phonebook/common/layout/default_layout.dart';
import 'package:phonebook/group/controller/group_controller.dart';
import 'package:phonebook/group/model/ministry.dart';

class MinistryMembersScreen extends StatefulWidget {
  MinistryMembersScreen({super.key, required this.ministry});

  final Ministry ministry;

  @override
  State<MinistryMembersScreen> createState() => _MinistryMembersScreenState();
}

class _MinistryMembersScreenState extends State<MinistryMembersScreen> {
  final groupCtrl = Get.find<GroupController>();

  @override
  void initState() {
    groupCtrl.getMinistryMembers(ministryId: widget.ministry.id);
    super.initState();
  }

  @override
  void dispose() {
    groupCtrl.ministryMembers.value = [];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: widget.ministry.name,
      centerTitle: true,
      backgroudColor: DETAIL_BG_COLOR,
      appBarColor: DETAIL_BG_COLOR,
      child: Obx(() {
        return groupCtrl.ministryMembers.isNotEmpty
            ? ListView.separated(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                itemBuilder: ((context, index) {
                  final member = groupCtrl.ministryMembers[index];
                  return ContactCard(member: member);
                }),
                separatorBuilder: ((context, index) {
                  return Gap(16);
                }),
                itemCount: groupCtrl.ministryMembers.length)
            : Container();
      }),
    );
  }
}
