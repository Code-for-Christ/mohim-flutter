import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phonebook/common/component/custom_rounded_button.dart';
import 'package:phonebook/common/component/custom_text_form_field.dart';
import 'package:phonebook/common/const/colors.dart';
import 'package:phonebook/common/const/data.dart';
import 'package:phonebook/common/const/style.dart';
import 'package:phonebook/user/controller/auth_controller.dart';
import 'package:phonebook/user/util/page_route_with_animation.dart';
import 'package:phonebook/user/view/email_code_input_screen.dart';
import 'package:phonebook/user/view/sign_up_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = '';
  String password = '';
  bool emailValidated = false;
  bool passwordValidated = false;

  bool isDisabled = true;

  final authCtrl = Get.put(AuthController());

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.92,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Form(
          key: _formKey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  alignment: Alignment.topLeft,
                  onPressed: () => Get.back(),
                  icon: Icon(
                    CupertinoIcons.clear,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      '로그인 하기',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.w900),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Gap(20),
                  CustomTextFormField(
                    onChanged: (value) {
                      setState(() {
                        email = value;
                      });
                      _formKey.currentState!.validate();
                    },
                    hintText: '이메일',
                    validator: (value) {
                      final regex = RegExp(emailPattern);
                      if (value == null || value.isEmpty) {
                        // emailValidated = false;
                        // return '입력창이 비어있습니다.';
                      } else if (!regex.hasMatch(value)) {
                        emailValidated = false;
                        return '올바른 이메일을 입력하세요';
                      } else {
                        emailValidated = true;
                        return null;
                      }
                    },
                  ),
                  Gap(16),
                  CustomTextFormField(
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                      _formKey.currentState!.validate();
                    },
                    hintText: '비밀번호',
                    obscureText: true,
                    validator: (value) {
                      final regex = RegExp(passwordPattern);
                      if (value == null || value.isEmpty) {
                        // passwordValidated = false;
                        // return '입력창이 비어있습니다.';
                      } else if (!regex.hasMatch(value)) {
                        passwordValidated = false;
                        return '영어, 숫자, 특수문자를 포함하여 8자 이상으로 입력하세요';
                      } else {
                        passwordValidated = true;
                        return null;
                      }
                    },
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: () {
                        PageRouteWithAnimation pageRouteWithAnimation =
                            PageRouteWithAnimation(EmailCodeInputScreen());
                        Navigator.push(context,
                            pageRouteWithAnimation.slideRitghtToLeft());
                      },
                      child: Text(
                        '비밀번호를 잊으셨나요?',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  Gap(30),
                  ElevatedButton(
                    style: buttonStyle,
                    onPressed: emailValidated && passwordValidated
                        ? () async {
                            setState(() {
                              emailValidated = false;
                            });
                            await authCtrl.login(email, password);
                            setState(() {
                              emailValidated = true;
                            });
                          }
                        : null,
                    child: Text(
                      '로그인하기',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Gap(20),
                  Text(
                    '계정이 없으신가요?',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  Gap(5),
                  CustomRoundedButton(
                      color: PRIMARY_COLOR,
                      filled: false,
                      height: 60,
                      onTap: () {
                        Get.back();
                        Get.bottomSheet(
                          SignUpScreen(),
                          isScrollControlled: true,
                          enterBottomSheetDuration: Duration(milliseconds: 200),
                        );
                      },
                      text: '시작하기'),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
