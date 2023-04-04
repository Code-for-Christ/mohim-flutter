import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:phonebook/common/const/type.dart';
import 'package:phonebook/common/layout/default_layout.dart';
import 'package:phonebook/group/component/group_card.dart';

class ParishListScreen extends StatelessWidget {
  const ParishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        child: ListView.separated(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            itemBuilder: ((context, index) {
              return GroupCard(
                icon: CupertinoIcons.group_solid,
                title: '${index+1}교구',
                subtitle: '${index+1}1, ${index+1}2, ${index+1}3, ${index+1}4, ${index+1}5구역',
                type: GroupType.cell,
              );
            }),
            separatorBuilder: ((context, index) {
              return Gap(16);
            }),
            itemCount: 4));
  }
}
