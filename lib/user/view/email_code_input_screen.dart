import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phonebook/common/component/custom_text_form_field.dart';
import 'package:phonebook/common/const/data.dart';
import 'package:phonebook/common/const/style.dart';
import 'package:phonebook/common/layout/default_layout.dart';
import 'package:phonebook/user/controller/auth_controller.dart';

class EmailCodeInputScreen extends StatefulWidget {
  const EmailCodeInputScreen({super.key});

  @override
  State<EmailCodeInputScreen> createState() => _EmailCodeInputScreenState();
}

class _EmailCodeInputScreenState extends State<EmailCodeInputScreen> {
  String email = '';
  bool emailValidated = false;

  final authCtrl = Get.find<AuthController>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '',
      appBarColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  '이메일을 입력해주세요',
                  style: title2TextStyle.copyWith(fontSize: 25),
                ),
              ),
              Gap(50),
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
                  } else if (!regex.hasMatch(value)) {
                    emailValidated = false;
                    return '올바른 이메일을 입력하세요';
                  } else {
                    emailValidated = true;
                    return null;
                  }
                },
              ),
              Gap(30),
              ElevatedButton(
                style: buttonStyle,
                onPressed: emailValidated
                    ? () async {
                        setState(() {
                          emailValidated = false;
                        });
                        await authCtrl.findPassword(email: email);
                        setState(() {
                          emailValidated = true;
                        });
                      }
                    : null,
                child: Text(
                  '이메일로 인증 코드받기',
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
    );
  }
}
