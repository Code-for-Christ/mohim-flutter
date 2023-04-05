import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phonebook/common/const/colors.dart';
import 'package:phonebook/common/const/style.dart';
import 'package:phonebook/common/model/church_member.dart';
import 'package:phonebook/contact/view/detail_screen.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({super.key, required this.member});
  final ChurchMember member;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(DetailScreen(
          member: member,
        ));
      },
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(16)),
          boxShadow: [
            // BoxShadow(
            //   blurRadius: 1,
            //   color: Color(0x411D2429),
            //   offset: Offset(0, 1),
            // ),
          ],
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
                  child: Image.memory(
                    Base64Codec().decode(member.thumbnail!),
                    width: 60,
                    height: 70,
                    fit: BoxFit.cover,
                  )),
            ],
          ),
          Gap(16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                member.name,
                style: body1TextStyle,
              ),
              Text(
                member.phoneNumber!,
                style: body2TextStyle,
              ),
            ],
          ),
          Spacer(),
          Icon(CupertinoIcons.chevron_forward)
        ]),
      ),
    );
  }
}
