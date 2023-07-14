import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:phonebook/common/const/colors.dart';
import 'package:phonebook/common/const/style.dart';

class EmptyLeaderCard extends StatelessWidget {
  const EmptyLeaderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
        Gap(4),
        Container(
          width: 70,
          height: 15,
          decoration: BoxDecoration(
            color: GRAY_LOGO_COLOR,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        Gap(4),
        Container(
          width: 45,
          height: 15,
          decoration: BoxDecoration(
            color: GRAY_LOGO_COLOR,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ],
    );
  }
}
