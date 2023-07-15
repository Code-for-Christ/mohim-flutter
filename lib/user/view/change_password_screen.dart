import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phonebook/common/component/custom_text_form_field.dart';
import 'package:phonebook/common/const/data.dart';
import 'package:phonebook/common/const/style.dart';
import 'package:phonebook/common/layout/default_layout.dart';
import 'package:phonebook/user/controller/auth_controller.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key, required this.email});
  final String email;

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  String password = '';

  String confirmationPassword = '';

  String code = '';

  bool codeValidated = false;
  bool passwordValidated = false;
  bool confirmationValidated = false;

  final _formKey = GlobalKey<FormState>();

  final authCtrl = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '',
      appBarColor: Colors.white,
      child: SingleChildScrollView(
          child: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '비밀번호 변경하기',
                    style: title2TextStyle,
                  ),
                ),
                Gap(50),
                CustomTextFormField(
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });
                    _formKey.currentState!.validate();
                  },
                  hintText: '새로운 비밀번호',
                  obscureText: true,
                  validator: (value) {
                    final regex = RegExp(passwordPattern);
                    if (value == null || value.isEmpty) {
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
                Gap(16),
                CustomTextFormField(
                  onChanged: (value) {
                    setState(() {
                      code = value;
                    });
                    _formKey.currentState!.validate();
                  },
                  hintText: '코드를 입력하세요',
                  validator: (value) {
                    // final regex = RegExp(emailPattern);
                    if (value == null || value.isEmpty) {
                      codeValidated = false;
                      // return '입력창이 비어있습니다.';
                    } else {
                      codeValidated = true;
                      return null;
                    }
                  },
                ),
                Gap(30),
                ElevatedButton(
                  style: buttonStyle,
                  onPressed: codeValidated &&
                          passwordValidated &&
                          confirmationValidated
                      ? () async {
                          setState(() {
                            codeValidated = false;
                          });
                          await authCtrl.changePassword(
                              email: widget.email,
                              password: password,
                              code: code);
                          setState(() {
                            codeValidated = true;
                          });
                        }
                      : null,
                  child: Text(
                    '변경하기',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
