import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phonebook/common/component/custom_rounded_button.dart';
import 'package:phonebook/common/component/custom_text_form_field.dart';
import 'package:phonebook/common/const/colors.dart';
import 'package:phonebook/common/const/data.dart';
import 'package:phonebook/user/controller/auth_controller.dart';
import 'package:phonebook/user/view/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String email = '';

  String password = '';

  String confirmationPassword = '';

  bool emailValidated = false;
  bool passwordValidated = false;
  bool confirmationValidated = false;

  final _formKey = GlobalKey<FormState>();

  final authCtrl = Get.put(AuthController());

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
                      '시작하기',
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
                        return '올바른 이메일 형식이 아닙니다.';
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
                        return '영어, 숫자를 포함하여 8자 이상으로 입력하세요.';
                      } else {
                        passwordValidated = true;
                        return null;
                      }
                    },
                  ),
                  Gap(16),
                  CustomTextFormField(
                    onChanged: (value) {
                      setState(() {
                        confirmationPassword = value;
                      });
                      _formKey.currentState!.validate();
                    },
                    obscureText: true,
                    hintText: '비밀번호 확인',
                    validator: (value) {
                      final regex = RegExp(passwordPattern);
                      if (value == null || value.isEmpty) {
                        // confirmationValidated = false;
                        // return '입력창이 비어있습니다.';
                      } else if (!regex.hasMatch(value)) {
                        confirmationValidated = false;
                        return '영어, 숫자를 포함하여 8자 이상으로 입력하세요.';
                      } else if (value != password) {
                        confirmationValidated = false;
                        return '비밀번호가 다릅니다';
                      } else {
                        confirmationValidated = true;
                        return null;
                      }
                    },
                  ),
                  Gap(30),
                  ElevatedButton(
                    style: buttonStyle,
                    onPressed: emailValidated &&
                            passwordValidated &&
                            confirmationValidated
                        ? () async {
                            authCtrl.signUp(email, password);
                          }
                        : null,
                    child: Text(
                      '시작하기',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Gap(100),
                  Text(
                    '이미 계정을 갖고 계신가요?',
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
                          LoginScreen(),
                          isScrollControlled: true,
                          enterBottomSheetDuration: Duration(milliseconds: 200),
                        );
                      },
                      text: '로그인하기'),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
