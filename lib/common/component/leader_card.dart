import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phonebook/common/component/ministry_label.dart';
import 'package:phonebook/common/const/colors.dart';
import 'package:phonebook/common/const/style.dart';
import 'package:phonebook/common/model/church_member.dart';

import '../../contact/view/detail_screen.dart';

class LeaderCard extends StatelessWidget {
  const LeaderCard({
    super.key,
    required this.name,
    required this.role,
    required this.thumbnail,
    required this.leader,
  });
  final dynamic leader;
  final String name;
  final String role;
  final String? thumbnail;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => Get.to(
              DetailScreen(
                member: leader,
              ),
              transition: Transition.cupertino),
          child: Stack(
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
              thumbnail != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.memory(
                        Base64Codec().decode(thumbnail!),
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
        ),
        Gap(4),
        MinistryLabel(ministryRole: role),
        Text(
          name,
          style: body2TextStyle.copyWith(
              color: Colors.black, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
