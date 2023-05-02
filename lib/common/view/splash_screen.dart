import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phonebook/common/const/colors.dart';
import 'package:phonebook/common/const/style.dart';
import 'package:phonebook/common/layout/default_layout.dart';
import 'package:phonebook/user/controller/auth_controller.dart';

class SplachScreen extends StatefulWidget {
  const SplachScreen({super.key});

  @override
  State<SplachScreen> createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen> {
  final authCtrl = Get.put(AuthController());

  @override
  void initState() {
    checkToken();
    super.initState();
  }

  checkToken() async {
    authCtrl.checkToken();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark));
    return DefaultLayout(
        backgroudColor: Colors.white,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'asset/img/logo/mohim_logo_ver2.png',
                  width: MediaQuery.of(context).size.width / 1.5,
                ),
                CircularProgressIndicator(
                  color: PRIMARY_COLOR,
                ),
              ],
            ),
          ),
        ));
  }
}
