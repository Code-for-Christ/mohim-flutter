import 'package:flutter/material.dart';
import 'package:phonebook/common/const/colors.dart';

class CustomSquareButton extends StatelessWidget {
  final Color color;
  final String text;
  final bool filled;
  final Function() onTap;
  final double height;

  const CustomSquareButton(
      {super.key,
      required this.color,
      required this.text,
      required this.filled,
      required this.onTap,
      required this.height});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
          height: height,
          decoration: BoxDecoration(
              color: filled ? PRIMARY_COLOR : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: PRIMARY_COLOR, width: 2.5)),
          child: Center(
              child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: filled ? Colors.white : PRIMARY_COLOR,
            ),
          )),
        ),
        onTap: onTap);
  }
}
