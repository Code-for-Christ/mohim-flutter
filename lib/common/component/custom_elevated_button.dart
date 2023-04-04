import 'package:flutter/material.dart';
import 'package:phonebook/common/const/colors.dart';

class CustomElevatedButton extends StatefulWidget {
  final String text;
  const CustomElevatedButton({
    super.key,
    required this.text,
  });

  @override
  State<CustomElevatedButton> createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton> {
  ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    minimumSize: Size(double.infinity, 60),
    elevation: 0,
    disabledBackgroundColor: INPUT_BG_COLOR,
    disabledForegroundColor: Colors.white,
    backgroundColor: PRIMARY_COLOR,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(50)),
    ),
  );

  bool isDisabled = false;

  setDisabled() {
    isDisabled = !isDisabled;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: buttonStyle,
      onPressed: isDisabled ? () {} : null,
      child: Text(
        widget.text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Colors.white,
        ),
      ),
    );
  }
}
