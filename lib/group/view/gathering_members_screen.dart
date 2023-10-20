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
    groupCtrl.getGatheringLeaders(gatheringId: widget.gathering.id);

    super.initState();
  }

  @override
  void dispose() {
    groupCtrl.gatheringMembers.value = [];
    groupCtrl.gatheringLeaders.value = [];
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
      child: SingleChildScrollView(
        controller: scrollCtrl,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                return groupCtrl.gatheringLeaders.isNotEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${widget.gathering.name}임원',
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
                                        groupCtrl.gatheringLeaders[index];
                                    return LeaderCard(
                                      leader: leader,
                                      name: leader.name,
                                      role: leader.gatheringRole!,
                                      thumbnail: leader.thumbnail,
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return Gap(8);
                                  },
                                  itemCount: groupCtrl.gatheringLeaders.length);
                            }),
                          ),
                        ],
                      )
                    : SizedBox();
              }),
              Gap(16),
              Text(
                '${widget.gathering.name}명단',
                style: body1TextStyle,
              ),
              Gap(8),
              Obx(() {
                return groupCtrl.gatheringMembers.isNotEmpty
                    ? ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
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
            ],
          ),
        ),
      ),
    );
  }
}
