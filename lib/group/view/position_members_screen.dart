import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phonebook/common/component/contact_card.dart';
import 'package:phonebook/common/const/colors.dart';
import 'package:phonebook/common/const/type.dart';
import 'package:phonebook/common/layout/default_layout.dart';
import 'package:phonebook/group/controller/group_controller.dart';
import 'package:phonebook/group/controller/pagination_controller.dart';
import 'package:phonebook/group/model/position.dart';

class PositionMembersScreen extends StatefulWidget {
  PositionMembersScreen({super.key, required this.position});

  final Position position;

  @override
  State<PositionMembersScreen> createState() => _PositionMembersScreenState();
}

class _PositionMembersScreenState extends State<PositionMembersScreen> {
  final groupCtrl = Get.find<GroupController>();
  final scrollCtrl = ScrollController();
  late final PaginationController paginationCtrl;

  @override
  void initState() {
    paginationCtrl = Get.put(PaginationController(
        scrollCtrl: scrollCtrl,
        type: GroupType.position,
        id: widget.position.id));
    groupCtrl.getPositionMembers(positionId: widget.position.id);
    groupCtrl.nextData.value = false;

    super.initState();
  }

  @override
  void dispose() {
    groupCtrl.positionMembers.value = [];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: widget.position.name,
      centerTitle: true,
      backgroudColor: DETAIL_BG_COLOR,
      appBarColor: DETAIL_BG_COLOR,
      child: Obx(() {
        return groupCtrl.positionMembers.isNotEmpty
            ? ListView.separated(
                controller: scrollCtrl,
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                itemBuilder: ((context, index) {
                  final member = groupCtrl.positionMembers[index];
                  return ContactCard(
                    member: member,
                  );
                }),
                separatorBuilder: ((context, index) {
                  return Gap(8);
                }),
                itemCount: groupCtrl.positionMembers.length)
            : Container();
      }),
    );
  }
}
