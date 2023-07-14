import 'package:flutter/material.dart';
import 'package:phonebook/common/const/colors.dart';

class MinistryLabel extends StatelessWidget {
  const MinistryLabel({super.key, required this.ministryRole});

  final String ministryRole;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 4, right: 4, bottom: 2),
        decoration: BoxDecoration(
          color: PRIMARY_COLOR,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: Text(
            ministryRole,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ));
  }
}
