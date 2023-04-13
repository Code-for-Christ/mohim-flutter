import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phonebook/common/component/custom_square_button.dart';
import 'package:phonebook/common/const/colors.dart';
import 'package:phonebook/common/const/style.dart';
import 'package:phonebook/common/layout/default_layout.dart';
import 'package:phonebook/profile/component/info_divider_box.dart';
import 'package:phonebook/profile/controller/profile_controller.dart';
import 'package:phonebook/profile/util/cache_manager.dart';
import 'package:phonebook/user/controller/auth_controller.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final profileCtrl = Get.put(ProfileController());

  String renderSalvationInfo() {
    if (profileCtrl.member.value.salvationMonth != null &&
        profileCtrl.member.value.salvationDay != null) {
      return '${profileCtrl.member.value.salvationYear}년 ${profileCtrl.member.value.salvationMonth}월 ${profileCtrl.member.value.salvationDay}일';
    }
    if (profileCtrl.member.value.salvationMonth != null &&
        profileCtrl.member.value.salvationDay == null) {
      return '${profileCtrl.member.value.salvationYear}년 ${profileCtrl.member.value.salvationMonth}월';
    }
    if (profileCtrl.member.value.salvationMonth == null &&
        profileCtrl.member.value.salvationDay != null) {
      return '${profileCtrl.member.value.salvationYear}년 ${profileCtrl.member.value.salvationDay}일';
    }
    return '${profileCtrl.member.value.salvationYear}년';
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      backgroudColor: Colors.white,
      child: Obx(() {
        return profileCtrl.member.value.name != ''
            ? Column(
                children: [
                  _ProfileBox(profileCtrl: profileCtrl),
                  Expanded(
                    child: ListView(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      shrinkWrap: true,
                      children: [
                        // AuthController.to.email.isNotEmpty
                        //     ? InfoDividerBox(
                        //         title: '이메일',
                        //         subTitle: AuthController.to.email,
                        //         icon: CupertinoIcons.mail_solid)
                        //     : SizedBox(),
                        profileCtrl.member.value.address != null
                            ? InfoDividerBox(
                                title: '주소',
                                subTitle: profileCtrl.member.value.address!,
                                icon: CupertinoIcons.house_fill)
                            : SizedBox(),
                        profileCtrl.member.value.cell != null
                            ? InfoDividerBox(
                                title: '구역',
                                subTitle:
                                    '${profileCtrl.member.value.cell!.toString()}구역',
                                icon: CupertinoIcons.person_2_fill)
                            : SizedBox(),
                        profileCtrl.ministryRoles.isNotEmpty
                            ? InfoDividerBox(
                                title: '봉사', subTitle: '', icon: Icons.bookmark)
                            : SizedBox(),
                        profileCtrl.member.value.gatheringName != null
                            ? InfoDividerBox(
                                title: '소속',
                                subTitle:
                                    profileCtrl.member.value.gatheringName!,
                                icon: CupertinoIcons.person_3_fill)
                            : SizedBox(),
                        profileCtrl.member.value.salvationYear != null ||
                                profileCtrl.member.value.salvationMonth !=
                                    null ||
                                profileCtrl.member.value.salvationDay != null
                            ? InfoDividerBox(
                                title: '구원생일',
                                subTitle: renderSalvationInfo(),
                                icon: Icons.celebration)
                            : SizedBox(),
                        profileCtrl.member.value.birthYear != null
                            ? InfoDividerBox(
                                title: '생년',
                                subTitle:
                                    '${profileCtrl.member.value.birthYear!.toString()}년',
                                icon: Icons.cake)
                            : SizedBox(),
                        profileCtrl.member.value.carNumber != null
                            ? InfoDividerBox(
                                title: '차량번호',
                                subTitle: profileCtrl.member.value.carNumber!,
                                icon: CupertinoIcons.car_fill)
                            : SizedBox(),
                        Gap(60),
                        CustomSquareButton(
                            color: PRIMARY_COLOR,
                            text: '로그아웃',
                            filled: true,
                            onTap: () {
                              Get.put(AuthController()).logout();
                            },
                            height: 60)
                      ],
                    ),
                  )
                ],
              )
            : Center(
                child: CircularProgressIndicator(color: PRIMARY_COLOR),
              );
      }),
    );
  }
}

class _ProfileBox extends StatelessWidget {
  const _ProfileBox({
    Key? key,
    required this.profileCtrl,
  }) : super(key: key);

  final ProfileController profileCtrl;

  renderSex() {
    if (profileCtrl.member.value.sex == null) {
      return '';
    }
    if (profileCtrl.member.value.sex == 'male') {
      return '형제';
    }
    if (profileCtrl.member.value.sex == 'female') {
      return '자매';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      height: MediaQuery.of(context).size.height / 4,
      width: double.infinity,
      decoration: BoxDecoration(
          color: PRIMARY_COLOR,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24))),
      child: Padding(
        padding: EdgeInsets.only(
          left: 24,
          bottom: 24,
          right: 24,
        ),
        child: Wrap(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _ProfileImage(),
                Gap(40),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${profileCtrl.member.value.name} ${renderSex()}',
                      style: titleTextStyle.copyWith(
                          fontWeight: FontWeight.w600, fontSize: 24),
                    ),
                    Gap(4),
                    profileCtrl.member.value.phoneNumber != null
                        ? Text(
                            profileCtrl.member.value.phoneNumber!,
                            style: body1TextStyle.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        : Container(),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileImage extends StatelessWidget {
  _ProfileImage({
    Key? key,
  }) : super(key: key);

  final double imageHeight = 180.0;
  final double imageWidht = 140.0;

  final profileCtrl = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      height: 130,
      width: 110,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        // boxShadow: [
        //   BoxShadow(
        //     blurRadius: 7,
        //     color: Color(0x411D2429),
        //     offset: Offset(0, 1),
        //   ),
        // ],
      ),
      child: Stack(
        children: [
          Container(
            width: imageWidht,
            height: imageHeight,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: INPUT_BG_COLOR),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: profileCtrl.imageUrl.isNotEmpty
                ?
                // Image.network(
                //     profileCtrl.imageUrl.value,
                //     width: imageWidht,
                //     height: imageHeight,
                //     fit: BoxFit.cover,
                //   )
                CachedNetworkImage(
                    imageUrl: profileCtrl.imageUrl.value,
                    errorWidget: (context, url, error) => Icon(
                      Icons.person,
                      size: 55,
                      color: PERSON_ICON_COLOR,
                    ),
                    width: imageWidht,
                    height: imageHeight,
                    fit: BoxFit.cover,
                    cacheManager: CustomCacheManager.instance,
                  )
                : Center(
                    child: Icon(
                    Icons.person,
                    color: PERSON_ICON_COLOR,
                    size: 55,
                  )),
          ),
        ],
      ),
    );
  }
}

class _InfoBox extends StatelessWidget {
  const _InfoBox({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.icon,
  }) : super(key: key);

  final String title;
  final String subTitle;
  final IconData icon;

  renderMinistries() {
    if (title != '봉사') {
      return subTitle;
    }

    final ministries = Get.find<ProfileController>()
        .ministryRoles
        .map((element) => element.ministryRole)
        .toList();

    return ministries.join(', ');
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: PRIMARY_COLOR,
        ),
        Gap(16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: body2TextStyle.copyWith(
                  color: BODY_TEXT_COLOR,
                  fontWeight: FontWeight.w500,
                  fontSize: 18),
            ),
            Gap(8),
            SizedBox(
              width: 300,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      renderMinistries(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: body1TextStyle.copyWith(
                          color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
