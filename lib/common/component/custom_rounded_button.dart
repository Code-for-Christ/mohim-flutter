import 'package:flutter/material.dart';
import 'package:phonebook/common/const/colors.dart';

class CustomRoundedButton extends StatelessWidget {
  final Color color;
  final String text;
  final bool filled;
  final Function() onTap;
  final double height;
  bool isActivatable;

  CustomRoundedButton({
    super.key,
    required this.color,
    required this.filled,
    required this.height,
    required this.onTap,
    required this.text,
    this.isActivatable = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
          height: height,
          decoration: BoxDecoration(
              color: filled ? INPUT_BG_COLOR : Colors.white,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                  color: filled ? INPUT_BG_COLOR : PRIMARY_COLOR, width: 2.5)),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: filled ? Colors.white : PRIMARY_COLOR,
              ),
            ),
          ),
        ),
        onTap: onTap);
  }
}
