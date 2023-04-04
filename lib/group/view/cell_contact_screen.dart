import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:phonebook/common/component/contact_card.dart';
import 'package:phonebook/common/const/colors.dart';
import 'package:phonebook/common/layout/default_layout.dart';

class CellContactScreen extends StatelessWidget {
  const CellContactScreen({super.key, required this.cell});
  final String cell;
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '$cell구역',
      centerTitle: true,
      appBarColor: DETAIL_BG_COLOR,
      backgroudColor: DETAIL_BG_COLOR,
      child: SafeArea(
        child: ListView.separated(
            padding: EdgeInsets.all(8),
            itemBuilder: ((context, index) {
              return Container();
            }),
            separatorBuilder: ((context, index) {
              return Gap(12);
            }),
            itemCount: 10),
      ),
    );
  }
}
