import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:phonebook/common/const/type.dart';
import 'package:phonebook/common/layout/default_layout.dart';
import 'package:phonebook/group/component/group_card.dart';

class MinistryScreen extends StatelessWidget {
  MinistryScreen({super.key});

  final _ministry = [
    '미디어선교부',
    '방송부',
    '찬양대',
    '교회학교',
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: ListView.separated(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          itemBuilder: ((context, index) {
            return GroupCard(
              icon: CupertinoIcons.group_solid,
              title: _ministry[index],
              subtitle: index == 3 ? '유치부, 초등부, 중고등부' : null,
              type: GroupType.ministry,
            );
          }),
          separatorBuilder: ((context, index) {
            return Gap(16);
          }),
          itemCount: 4),
    );
  }
}
