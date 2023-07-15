import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:phonebook/common/const/colors.dart';
import 'package:phonebook/common/const/style.dart';
import 'package:phonebook/common/layout/default_layout.dart';
import 'package:phonebook/user/controller/auth_controller.dart';

class DeleteAccountScreen extends StatefulWidget {
  const DeleteAccountScreen({super.key});

  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '회원탈퇴',
      appBarColor: Colors.white,
      centerTitle: true,
      child: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                Gap(50),
                Text(
                  '모힘 탈퇴 전 꼭 확인하세요!',
                  style: titleTextStyle.copyWith(
                      color: Colors.black, fontSize: 24),
                ),
                Gap(30),
                _WarningTextBox(),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      activeColor: PRIMARY_COLOR,
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                      shape: CircleBorder(),
                    ),
                    Text(
                      '상기된 내용을 모두 인지하였습니다.',
                      style: body2TextStyle.copyWith(color: Colors.black),
                    ),
                  ],
                ),
                Gap(10),
                ElevatedButton(
                    style: buttonStyle,
                    onPressed: isChecked
                        ? () {
                            AuthController.to.deleteAccount();
                          }
                        : null,
                    child: Text(
                      '탈퇴하기',
                      style: buttonTextStyle,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _WarningTextBox extends StatelessWidget {
  const _WarningTextBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      width: 330,
      decoration: BoxDecoration(
          color: DETAIL_BG_COLOR, borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '회원정보',
                style: body1TextStyle,
              ),
              Text(
                '이메일, 비밀번호 등 모든 계정정보가 삭제되며 복구가 불가능합니다.',
                style: body2TextStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
