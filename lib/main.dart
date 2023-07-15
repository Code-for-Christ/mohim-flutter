import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:phonebook/common/http/my_http_overrides.dart';
import 'package:phonebook/common/const/colors.dart';
import 'package:phonebook/common/view/splash_screen.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(_App());
}

class _App extends StatelessWidget {
  const _App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'phonebook',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: PRIMARY_COLOR,
          fontFamily: 'NotoSans',
          platform: TargetPlatform.iOS),
      home: SplachScreen(),
    );
  }
}
