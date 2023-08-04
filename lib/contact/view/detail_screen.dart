import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phonebook/common/const/colors.dart';
import 'package:phonebook/common/const/style.dart';
import 'package:phonebook/common/layout/default_layout.dart';
import 'package:phonebook/common/model/church_member.dart';
import 'package:phonebook/contact/component/household_card.dart';
import 'package:phonebook/contact/component/information_card.dart';
import 'package:phonebook/contact/controller/member_controller.dart';
import 'package:phonebook/contact/model/church_member_detail.dart';
import 'package:phonebook/contact/view/image_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatefulWidget {
  DetailScreen({
    super.key,
    required this.member,
  });

  final dynamic member;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final memberCtrl = Get.find<MemberController>();
  // 이미지 넓이
  double imageWidth = 140;
  // 이미지 높이
  double imageHeight = 180;

  String renderSex() {
    return memberCtrl.churchMemberDetail.value.sex == 'male' ? '형제' : '자매';
  }

  String renderSalvationInfo() {
    if (memberCtrl.churchMemberDetail.value.salvationMonth != null &&
        memberCtrl.churchMemberDetail.value.salvationDay != null) {
      return '${memberCtrl.churchMemberDetail.value.salvationYear}년 ${memberCtrl.churchMemberDetail.value.salvationMonth}월 ${memberCtrl.churchMemberDetail.value.salvationDay}일';
    }
    if (memberCtrl.churchMemberDetail.value.salvationMonth != null &&
        memberCtrl.churchMemberDetail.value.salvationDay == null) {
      return '${memberCtrl.churchMemberDetail.value.salvationYear}년 ${memberCtrl.churchMemberDetail.value.salvationMonth}월';
    }
    if (memberCtrl.churchMemberDetail.value.salvationMonth == null &&
        memberCtrl.churchMemberDetail.value.salvationDay != null) {
      return '${memberCtrl.churchMemberDetail.value.salvationYear}년 ${memberCtrl.churchMemberDetail.value.salvationDay}일';
    }
    return '${memberCtrl.churchMemberDetail.value.salvationYear}년';
  }

  renderMinistries() {
    String joinedString = memberCtrl.churchMemberDetail.value.ministries
        .map((e) => e.role != null ? '${e.name}(${e.role})' : '${e.name}')
        .join('\n');

    return joinedString;
  }

  @override
  void initState() {
    getProfileImage();
    getChurchMember();
    super.initState();
  }

  @override
  void dispose() {
    memberCtrl.profileImageUrl.value = '';
    memberCtrl.ministryRoles.value = [];
    memberCtrl.isFetchingChurchMemberDetail.value = true;
    memberCtrl.churchMemberDetail.value = ChurchMemberDetail(
        address: '',
        birthYear: 0,
        carNumber: '',
        cell: 0,
        cellId: 0,
        cellRole: '',
        chruchName: '',
        churchId: 0,
        gatheringId: 0,
        gatheringName: '',
        gatheringRole: '',
        household: [],
        householderId: 0,
        id: 0,
        ministries: [],
        name: '',
        parish: 0,
        parishRole: '',
        phoneNumber: '',
        positionId: 0,
        positionName: '',
        relationshipWithHouseholder: '',
        salvationDay: 0,
        salvationMonth: 0,
        salvationYear: 0,
        sex: '',
        thumbnail: '');
    super.dispose();
  }

  getProfileImage() async {
    await memberCtrl.getProfileImageUrl(memberId: widget.member.id);
  }

  getChurchMember() async {
    await memberCtrl.getChurchMember(memberId: widget.member.id);
  }

  @override
  Widget build(BuildContext context) {
    final String phoneNumber = widget.member.phoneNumber != null
        ? widget.member.phoneNumber!
        : '전화번호가 없습니다';

    return DefaultLayout(
      title: '',
      appBarColor: INPUT_BG_COLOR,
      backgroudColor: INPUT_BG_COLOR,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            children: [
              Gap(8),
              _ProfileImageBox(
                  memberCtrl: memberCtrl,
                  imageWidth: imageWidth,
                  imageHeight: imageHeight),
              Gap(8),
              Obx(() {
                return memberCtrl.isFetchingChurchMemberDetail.value
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height / 2,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: PRIMARY_COLOR,
                          ),
                        ),
                      )
                    : Column(
                        children: [
                          Text(
                            memberCtrl.churchMemberDetail.value.name,
                            style: titleTextStyle.copyWith(color: Colors.black),
                          ),
                          memberCtrl.churchMemberDetail.value!.positionName !=
                                  null
                              ? Text(
                                  '${memberCtrl.churchMemberDetail.value!.positionName}',
                                  style: body1TextStyle.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: BODY_TEXT_COLOR),
                                )
                              : Text(
                                  renderSex(),
                                  style: body1TextStyle.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: BODY_TEXT_COLOR),
                                ),
                          ElevatedButton(
                            onPressed: memberCtrl
                                        .churchMemberDetail.value.phoneNumber !=
                                    null
                                ? () async {
                                    String number = phoneNumber;
                                    final url = Platform.isIOS
                                        ? 'tel://$number'
                                        : 'tel:$number';
                                    await launchUrl(Uri.parse(url));
                                  }
                                : null,
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: PRIMARY_COLOR,
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                              ),
                            ),
                            child: Wrap(
                              children: [
                                Icon(CupertinoIcons.phone_fill),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  phoneNumber,
                                  style: body1TextStyle.copyWith(
                                      color: Colors.white, height: 1.2),
                                ),
                              ],
                            ),
                          ),
                          Gap(16),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '소속',
                                  style: body1TextStyle,
                                ),
                              ],
                            ),
                          ),
                          Gap(8),
                          InformationCard(
                              height: 50,
                              text: '교구',
                              data: memberCtrl.churchMemberDetail.value
                                          .parishRole ==
                                      null
                                  ? '${memberCtrl.churchMemberDetail.value.parish.toString()}교구'
                                  : '${memberCtrl.churchMemberDetail.value.parish.toString()}교구(${memberCtrl.churchMemberDetail.value.parishRole})'),
                          Gap(8),
                          InformationCard(
                              height: 50,
                              text: '구역',
                              data: memberCtrl
                                          .churchMemberDetail.value.cellRole ==
                                      null
                                  ? '${memberCtrl.churchMemberDetail.value.cell.toString()}구역'
                                  : '${memberCtrl.churchMemberDetail.value.cell.toString()}구역(${memberCtrl.churchMemberDetail.value.cellRole})'),
                          Gap(8),
                          InformationCard(
                              height: 50,
                              text: '교제부서',
                              data: memberCtrl.churchMemberDetail.value
                                          .gatheringRole ==
                                      null
                                  ? '${memberCtrl.churchMemberDetail.value.gatheringName}'
                                  : '${memberCtrl.churchMemberDetail.value.gatheringName}(${memberCtrl.churchMemberDetail.value.gatheringRole})'),
                          Gap(8),
                          memberCtrl.churchMemberDetail.value.ministries
                                  .isNotEmpty
                              ? InformationCard(
                                  height: 50,
                                  text: '봉사',
                                  data: renderMinistries())
                              : Container(),
                          Gap(24),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '인적사항',
                                  style: body1TextStyle,
                                ),
                              ],
                            ),
                          ),
                          Gap(8),
                          memberCtrl.churchMemberDetail.value.birthYear == null
                              ? Container()
                              : InformationCard(
                                  height: 50,
                                  text: '생년',
                                  data:
                                      '${memberCtrl.churchMemberDetail.value.birthYear}년'),
                          Gap(8),
                          memberCtrl.churchMemberDetail.value.salvationYear ==
                                  null
                              ? Container()
                              : InformationCard(
                                  height: 50,
                                  text: '구원생일',
                                  data: renderSalvationInfo()),
                          Gap(8),
                          memberCtrl.churchMemberDetail.value.address == null
                              ? Container()
                              : InformationCard(
                                  height: 50,
                                  text: '주소',
                                  data:
                                      '${memberCtrl.churchMemberDetail.value.address}'),
                          Gap(8),
                          memberCtrl.churchMemberDetail.value.carNumber == null
                              ? Container()
                              : InformationCard(
                                  height: 50,
                                  text: '차량번호',
                                  data:
                                      '${memberCtrl.churchMemberDetail.value.carNumber}'),
                          Gap(24),
                          memberCtrl.churchMemberDetail.value.household.isEmpty
                              ? Container()
                              : SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '세대정보 (세대주와의 관계: ${memberCtrl.churchMemberDetail.value.relationshipWithHouseholder})',
                                        style: body1TextStyle,
                                      ),
                                      Gap(8),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 150,
                                        child: ListView.separated(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) {
                                              final member = memberCtrl
                                                  .churchMemberDetail
                                                  .value
                                                  .household[index];
                                              return HouseholdCard(
                                                  member: member);
                                            },
                                            separatorBuilder: (context, index) {
                                              return Gap(8);
                                            },
                                            itemCount: memberCtrl
                                                .churchMemberDetail
                                                .value
                                                .household
                                                .length),
                                      ),
                                    ],
                                  ),
                                ),
                        ],
                      );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileImageBox extends StatelessWidget {
  const _ProfileImageBox({
    Key? key,
    required this.memberCtrl,
    required this.imageWidth,
    required this.imageHeight,
  }) : super(key: key);

  final MemberController memberCtrl;
  final double imageWidth;
  final double imageHeight;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(
        ImageScreen(),
        fullscreenDialog: true,
      ),
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                blurRadius: 7,
                color: Color(0x411D2429),
                offset: Offset(0, 1),
              ),
            ]),
        child: Obx(() {
          return Stack(
            children: [
              Container(
                width: imageWidth,
                height: imageHeight,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: INPUT_BG_COLOR),
              ),
              memberCtrl.profileImageUrl.isEmpty
                  ? SizedBox(
                      width: imageWidth,
                      height: imageHeight,
                      child: Icon(
                        Icons.person,
                        size: 55,
                        color: BODY_TEXT_COLOR,
                      ))
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(7),
                      child: Image.network(
                        memberCtrl.profileImageUrl.value,
                        width: imageWidth,
                        height: imageHeight,
                        fit: BoxFit.cover,
                      ),
                    ),
            ],
          );
        }),
      ),
    );
  }
}
