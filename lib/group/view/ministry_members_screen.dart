import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:phonebook/common/component/contact_card.dart';
import 'package:phonebook/common/component/leader_card.dart';
import 'package:phonebook/common/const/colors.dart';
import 'package:phonebook/common/const/style.dart';
import 'package:phonebook/common/const/type.dart';
import 'package:phonebook/common/layout/default_layout.dart';
import 'package:phonebook/group/controller/group_controller.dart';
import 'package:phonebook/group/controller/pagination_controller.dart';
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
    groupCtrl.getMinistryLeaders(ministryId: widget.ministry.id);
    groupCtrl.getMinistryMembers(ministryId: widget.ministry.id);
    super.initState();
  }

  @override
  void dispose() {
    groupCtrl.ministryLeaders.value = [];
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
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                return groupCtrl.ministryLeaders.isNotEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${widget.ministry.name}임원',
                            style: body1TextStyle,
                          ),
                          Gap(8),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 150,
                            child: Obx(() {
                              return ListView.separated(
                                  // 성공적으로 데이터를 불러올 경우
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    final leader =
                                        groupCtrl.ministryLeaders[index];
                                    return LeaderCard(
                                      leader: leader,
                                      name: leader.name,
                                      role: leader.ministryRole!,
                                      thumbnail: leader.thumbnail,
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return Gap(8);
                                  },
                                  itemCount: groupCtrl.ministryLeaders.length);
                            }),
                          ),
                        ],
                      )
                    : SizedBox();
              }),
              Gap(16),
              Text('${widget.ministry.name}명단', style: body1TextStyle),
              Obx(() {
                return groupCtrl.ministryMembers.isNotEmpty
                    ? ListView.separated(
                        padding: EdgeInsets.symmetric(
                          vertical: 8,
                        ),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: ((context, index) {
                          final member = groupCtrl.ministryMembers[index];
                          return ContactCard(
                            member: member,
                          );
                        }),
                        separatorBuilder: ((context, index) {
                          return Gap(8);
                        }),
                        itemCount: groupCtrl.ministryMembers.length)
                    : Container();
              }),
            ],
          ),
        ),
      ),
    );
  }
}
