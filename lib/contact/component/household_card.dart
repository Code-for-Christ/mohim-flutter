import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phonebook/common/component/ministry_label.dart';
import 'package:phonebook/common/const/colors.dart';
import 'package:phonebook/common/const/style.dart';
import 'package:phonebook/contact/model/household.dart';
import 'package:phonebook/contact/view/detail_screen.dart';

class HouseholdCard extends StatelessWidget {
  const HouseholdCard({
    super.key,
    required this.member,
  });

  final HouseHold member;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 96,
                width: 76,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: GRAY_LOGO_COLOR,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              member.profileImageThumbnail != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.memory(
                        Base64Codec().decode(member.profileImageThumbnail!),
                        width: 76,
                        height: 96,
                        fit: BoxFit.cover,
                      ))
                  : SizedBox(
                      height: 96,
                      width: 76,
                      child: Center(child: emptyPersonIcon)),
            ],
          ),
          Gap(4),
          MinistryLabel(
              ministryRole: member.relationshipWithHouseholder! == '본인'
                  ? '세대주'
                  : member.relationshipWithHouseholder!),
          Text(
            member.name,
            style: body2TextStyle.copyWith(
                color: Colors.black, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
