import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phonebook/common/const/colors.dart';
import 'package:phonebook/common/layout/default_layout.dart';
import 'package:phonebook/group/component/list_card.dart';
import 'package:phonebook/group/view/cell_contact_screen.dart';

class CellListScreen extends StatelessWidget {
  const CellListScreen({super.key, required this.parish});
  final int parish;
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '$parish교구',
      centerTitle: true,
      appBarColor: DETAIL_BG_COLOR,
      backgroudColor: DETAIL_BG_COLOR,
      // appBarBottom: PreferredSize(
      //   preferredSize: Size(double.infinity, double.minPositive),
      //   child: Text('구역을 선택하세요'),
      // ),
      child: ListView.separated(
          padding: EdgeInsets.all(16),
          itemBuilder: ((context, index) {
            return ListCard(
              cell: '$parish${index + 1}구역',
              onTap: () =>
                  Get.to(CellContactScreen(cell: '$parish${index + 1}')),
            );
          }),
          separatorBuilder: ((context, index) {
            return Gap(16);
          }),
          itemCount: 5),
    );
  }
}
