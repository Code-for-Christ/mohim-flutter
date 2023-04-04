import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phonebook/common/const/colors.dart';
import 'package:phonebook/common/view/splash_screen.dart';

void main() {
  runApp(_App());
}

class _App extends StatelessWidget {
  const _App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'phonebook',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: PRIMARY_COLOR,
        fontFamily: 'NotoSans',
      ),
      home: SplachScreen(),
    );
  }
}
