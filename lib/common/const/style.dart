import 'package:flutter/material.dart';
import 'package:phonebook/common/const/colors.dart';

TextStyle titleTextStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 30,
  color: Colors.white,
);
TextStyle body1TextStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 18,
  color: Colors.black,
);
TextStyle body2TextStyle = TextStyle(
  fontWeight: FontWeight.w400,
  fontSize: 14,
  color: BODY_TEXT_COLOR,
);
TextStyle title2TextStyle =
    TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.w900);

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
TextStyle buttonTextStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 18,
  color: Colors.white,
);

Icon emptyPersonIcon = Icon(
  Icons.person,
  size: 45,
  color: BODY_TEXT_COLOR,
);
