import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:phonebook/common/const/type.dart';
import 'package:phonebook/common/layout/default_layout.dart';
import 'package:phonebook/group/component/group_card.dart';

class GatheringListScreen extends StatelessWidget {
  GatheringListScreen({super.key});

  final _gathering = ['봉사회', '어머니회', '은빛장년회', '청년회'];

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        child: ListView.separated(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            itemBuilder: ((context, index) {
              return GroupCard(
                icon: CupertinoIcons.group_solid,
                title: _gathering[index],
                type: GroupType.gathering,
              );
            }),
            separatorBuilder: ((context, index) {
              return Gap(16);
            }),
            itemCount: 4));
  }
}
