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

class AuthBranchScreen extends StatelessWidget {
  const AuthBranchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Mohim',
                style:
                    titleTextStyle.copyWith(fontSize: 45, color: PRIMARY_COLOR),
              ),
              Gap(150),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
