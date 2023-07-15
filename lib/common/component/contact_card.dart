import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phonebook/common/component/ministry_label.dart';
import 'package:phonebook/common/const/colors.dart';
import 'package:phonebook/common/const/style.dart';
import 'package:phonebook/contact/view/detail_screen.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({super.key, required this.member, this.ministryRole});
  final dynamic member;
  final String? ministryRole;
  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        color: Colors.white,
      ),
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        onTap: () {
          Get.to(
              DetailScreen(
                member: member,
              ),
              transition: Transition.cupertino);
        },
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: Row(children: [
            Stack(
              children: [
                Container(
                  width: 60,
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: INPUT_BG_COLOR,
                  ),
                  child: Icon(
                    Icons.person,
                    size: 35,
                    color: BODY_TEXT_COLOR,
                  ),
                ),
                ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: member.thumbnail != null
                        ? Image.memory(
                            Base64Codec().decode(member.thumbnail!),
                            width: 60,
                            height: 70,
                            fit: BoxFit.cover,
                          )
                        : Container()),
              ],
            ),
            Gap(16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      member.name,
                      style: body1TextStyle,
                    ),
                    Gap(8),
                    ministryRole != null
                        ? MinistryLabel(ministryRole: ministryRole!)
                        : SizedBox(),
                  ],
                ),
                member.phoneNumber != null
                    ? Column(
                        children: [
                          Gap(5),
                          Text(
                            member.phoneNumber!,
                            style: body2TextStyle,
                          ),
                        ],
                      )
                    : Container(),
              ],
            ),
            Spacer(),
            Icon(CupertinoIcons.chevron_forward)
          ]),
        ),
      ),
    );
  }
}
