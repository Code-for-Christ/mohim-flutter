import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phonebook/common/const/style.dart';
import 'package:phonebook/common/controller/modal_detail_controller.dart';
import 'package:phonebook/common/layout/default_layout.dart';
import 'package:phonebook/contact/component/household_card.dart';
import 'package:phonebook/contact/component/information_card.dart';
import 'package:url_launcher/url_launcher.dart';

import '../const/colors.dart';

class BottomModalDetailScreen extends StatelessWidget {
  BottomModalDetailScreen({super.key, required this.memberId});

  // 이미지 넓이
  double imageWidth = 140;

  // 이미지 높이
  double imageHeight = 180;

  final int memberId;
  final modalCtrl = Get.put(ModalDetailController());

  @override
  Widget build(BuildContext context) {
    modalCtrl.loadData(memberId: memberId);

    String renderSalvationInfo() {
      if (modalCtrl.churchMemberDetail.value.salvationMonth != null &&
          modalCtrl.churchMemberDetail.value.salvationDay != null) {
        return '${modalCtrl.churchMemberDetail.value.salvationYear}년 ${modalCtrl.churchMemberDetail.value.salvationMonth}월 ${modalCtrl.churchMemberDetail.value.salvationDay}일';
      }
      if (modalCtrl.churchMemberDetail.value.salvationMonth != null &&
          modalCtrl.churchMemberDetail.value.salvationDay == null) {
        return '${modalCtrl.churchMemberDetail.value.salvationYear}년 ${modalCtrl.churchMemberDetail.value.salvationMonth}월';
      }
      if (modalCtrl.churchMemberDetail.value.salvationMonth == null &&
          modalCtrl.churchMemberDetail.value.salvationDay != null) {
        return '${modalCtrl.churchMemberDetail.value.salvationYear}년 ${modalCtrl.churchMemberDetail.value.salvationDay}일';
      }
      return '${modalCtrl.churchMemberDetail.value.salvationYear}년';
    }

    renderMinistries() {
      String joinedString = modalCtrl.churchMemberDetail.value.ministries
          .map((e) => e.role != null ? '${e.name}(${e.role})' : e.name)
          .join('\n');

      return joinedString;
    }

    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Column(
            children: [
              Column(
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
                            width: imageWidth,
                            height: imageHeight,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: INPUT_BG_COLOR),
                          ),
                          modalCtrl.profileImageUrl.isEmpty
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
                                    modalCtrl.profileImageUrl.value,
                                    width: imageWidth,
                                    height: imageHeight,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ],
                      );
                    }),
                  ),
                  Gap(8),
                  Obx(() {
                    return modalCtrl.isFetchingChurchMemberDetail.value
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
                                modalCtrl.churchMemberDetail.value.name,
                                style: titleTextStyle.copyWith(
                                    color: Colors.black),
                              ),
                              modalCtrl.churchMemberDetail.value!
                                          .positionName !=
                                      null
                                  ? Text(
                                      '${modalCtrl.churchMemberDetail.value!.positionName}',
                                      style: body1TextStyle.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: BODY_TEXT_COLOR),
                                    )
                                  : Text(
                                      modalCtrl.churchMemberDetail.value
                                                  .sex ==
                                              'male'
                                          ? '형제'
                                          : '자매',
                                      style: body1TextStyle.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: BODY_TEXT_COLOR),
                                    ),
                              ElevatedButton(
                                onPressed: modalCtrl.churchMemberDetail.value
                                            .phoneNumber !=
                                        null
                                    ? () async {
                                        String number = modalCtrl
                                            .churchMemberDetail
                                            .value
                                            .phoneNumber!;
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
                                      modalCtrl.churchMemberDetail.value
                                          .phoneNumber!,
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
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
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
                                  data: modalCtrl.churchMemberDetail.value
                                              .parishRole ==
                                          null
                                      ? '${modalCtrl.churchMemberDetail.value.parish.toString()}교구'
                                      : '${modalCtrl.churchMemberDetail.value.parish.toString()}교구(${modalCtrl.churchMemberDetail.value.parishRole})'),
                              Gap(8),
                              InformationCard(
                                  height: 50,
                                  text: '구역',
                                  data: modalCtrl.churchMemberDetail.value
                                              .cellRole ==
                                          null
                                      ? '${modalCtrl.churchMemberDetail.value.cell.toString()}구역'
                                      : '${modalCtrl.churchMemberDetail.value.cell.toString()}구역(${modalCtrl.churchMemberDetail.value.cellRole})'),
                              Gap(8),
                              InformationCard(
                                  height: 50,
                                  text: '교제부서',
                                  data: modalCtrl.churchMemberDetail.value
                                              .gatheringRole ==
                                          null
                                      ? '${modalCtrl.churchMemberDetail.value.gatheringName}'
                                      : '${modalCtrl.churchMemberDetail.value.gatheringName}(${modalCtrl.churchMemberDetail.value.gatheringRole})'),
                              Gap(8),
                              modalCtrl.churchMemberDetail.value.ministries
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
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '인적사항',
                                      style: body1TextStyle,
                                    ),
                                  ],
                                ),
                              ),
                              Gap(8),
                              modalCtrl.churchMemberDetail.value.birthYear ==
                                      null
                                  ? Container()
                                  : InformationCard(
                                      height: 50,
                                      text: '생년',
                                      data:
                                          '${modalCtrl.churchMemberDetail.value.birthYear}년'),
                              Gap(8),
                              modalCtrl.churchMemberDetail.value
                                          .salvationYear ==
                                      null
                                  ? Container()
                                  : InformationCard(
                                      height: 50,
                                      text: '구원생일',
                                      data: renderSalvationInfo()),
                              Gap(8),
                              modalCtrl.churchMemberDetail.value.address ==
                                      null
                                  ? Container()
                                  : InformationCard(
                                      height: 50,
                                      text: '주소',
                                      data:
                                          '${modalCtrl.churchMemberDetail.value.address}'),
                              Gap(8),
                              modalCtrl.churchMemberDetail.value.carNumber ==
                                      null
                                  ? Container()
                                  : InformationCard(
                                      height: 50,
                                      text: '차량번호',
                                      data:
                                          '${modalCtrl.churchMemberDetail.value.carNumber}'),
                            ],
                          );
                  }),
                ],
              ),
              Gap(16),
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
    required this.modalCtrl,
    required this.imageWidth,
    required this.imageHeight,
  }) : super(key: key);

  final ModalDetailController modalCtrl;
  final double imageWidth;
  final double imageHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
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
            modalCtrl.profileImageUrl.isEmpty
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
                      modalCtrl.profileImageUrl.value,
                      width: imageWidth,
                      height: imageHeight,
                      fit: BoxFit.cover,
                    ),
                  ),
          ],
        );
      }),
    );
  }
}
