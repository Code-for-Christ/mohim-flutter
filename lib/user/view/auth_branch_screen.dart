import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:phonebook/common/component/custom_square_button.dart';
import 'package:phonebook/common/const/colors.dart';
import 'package:phonebook/common/const/style.dart';
import 'package:phonebook/common/layout/default_layout.dart';
import 'package:phonebook/user/view/login_screen.dart';
import 'package:phonebook/user/view/sign_up_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthBranchScreen extends StatelessWidget {
  const AuthBranchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'asset/img/logo/mohim_logo.png',
                    width: MediaQuery.of(context).size.width,
                  ),
                  CustomSquareButton(
                    color: PRIMARY_COLOR,
                    text: '로그인',
                    filled: false,
                    height: 60,
                    onTap: () => Get.bottomSheet(
                      LoginScreen(),
                      isScrollControlled: T,
                      enterBottomSheetDuration: Duration(milliseconds: 200),
                    ),
                  ),
                  Gap(16),
                  CustomSquareButton(
                    color: PRIMARY_COLOR,
                    text: '이메일로 시작하기',
                    filled: true,
                    height: 60,
                    onTap: () => Get.bottomSheet(
                      SignUpScreen(),
                      isScrollControlled: T,
                      enterBottomSheetDuration: Duration(milliseconds: 200),
                    ),
                  ),
                  TextButton(
                      onPressed: () async {
                        final url = Uri.parse(
                            'https://sites.google.com/view/mohim-privacy-policy');
                        if (await canLaunchUrl(url)) {
                          // if (Platform.isIOS) {
                          launchUrl(url, mode: LaunchMode.inAppWebView);
                          // }
                          // if (Platform.isAndroid){
                          //   launchUrl(url, mode: )
                          // }
                        }
                      },
                      child: Text('개인정보 처리방침')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
