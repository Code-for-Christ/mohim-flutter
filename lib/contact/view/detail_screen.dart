import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phonebook/common/const/colors.dart';
import 'package:phonebook/common/const/style.dart';
import 'package:phonebook/common/layout/default_layout.dart';
import 'package:phonebook/common/model/church_member.dart';
import 'package:phonebook/contact/component/information_card.dart';
import 'package:phonebook/contact/controller/member_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatefulWidget {
  DetailScreen({
    super.key,
    required this.member,
  });

  final ChurchMember member;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final memberCtrl = Get.find<MemberController>();
  // 이미지 넓이
  final imageWidth = 120.0;
  // 이미지 높이
  final imageHeight = 140.0;

  String renderSex() {
    return widget.member.sex == 'male' ? '형제' : '자매';
  }

  String renderSalvationInfo() {
    if (widget.member.salvationMonth != null &&
        widget.member.salvationDay != null) {
      return '${widget.member.salvationYear}년 ${widget.member.salvationMonth}월 ${widget.member.salvationDay}일';
    }
    if (widget.member.salvationMonth != null &&
        widget.member.salvationDay == null) {
      return '${widget.member.salvationYear}년 ${widget.member.salvationMonth}월';
    }
    if (widget.member.salvationMonth == null &&
        widget.member.salvationDay != null) {
      return '${widget.member.salvationYear}년 ${widget.member.salvationDay}일';
    }
    return '${widget.member.salvationYear}년';
  }

  @override
  void initState() {
    memberCtrl.getProfileImageUrl(memberId: widget.member.id);
    super.initState();
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
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Center(
            child: Column(
              children: [
                Container(
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
                          width: 120,
                          height: 140,
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
                Gap(4),
                Text(
                  widget.member.name,
                  style: titleTextStyle.copyWith(color: Colors.black),
                ),
                Text(
                  '${widget.member.cell}구역 ${renderSex()}',
                  style: body1TextStyle.copyWith(
                      fontWeight: FontWeight.w600, color: BODY_TEXT_COLOR),
                ),
                Gap(16),
                ElevatedButton(
                  onPressed: widget.member.phoneNumber != null
                      ? () async {
                          String number = phoneNumber;
                          final url =
                              Platform.isIOS ? 'tel://$number' : 'tel:$number';
                          await launchUrl(Uri.parse(url));
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: PRIMARY_COLOR,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
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
                        style: body1TextStyle.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Gap(30),
                widget.member.carNumber != null
                    ? InformationCard(
                        icon: CupertinoIcons.car,
                        height: 50,
                        text: '차량번호',
                        data: widget.member.carNumber!,
                      )
                    : Container(),
                Gap(16),
                widget.member.address != null
                    ? InformationCard(
                        icon: CupertinoIcons.house_fill,
                        height: 50,
                        text: '집주소',
                        data: widget.member.address!,
                      )
                    : Container(),
                Gap(16),
                widget.member.salvationYear != null
                    ? InformationCard(
                        icon: CupertinoIcons.gift_fill,
                        height: 50,
                        text: '구원생일',
                        data: renderSalvationInfo(),
                      )
                    : Container(),
                Gap(16),
                widget.member.gatheringName != null
                    ? InformationCard(
                        icon: Icons.bookmark,
                        height: 50,
                        text: '소속',
                        data: widget.member.gatheringName!,
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
