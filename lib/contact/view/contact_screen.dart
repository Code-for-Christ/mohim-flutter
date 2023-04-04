import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:phonebook/common/component/custom_text_form_field.dart';
import 'package:phonebook/common/const/colors.dart';
import 'package:phonebook/common/const/style.dart';
import 'package:phonebook/common/component/contact_card.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: INPUT_BG_COLOR,
      appBar: _appBar(),
      body: ListView.separated(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          itemBuilder: ((context, index) {
            return ContactCard();
          }),
          separatorBuilder: ((context, index) {
            return Gap(10);
          }),
          itemCount: 10),
    );
  }

  AppBar _appBar() {
    return AppBar(
        title: Text(
          '전화번호부',
          style: titleTextStyle.copyWith(color: Colors.black, fontSize: 22),
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: Size(double.infinity, 72),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: CustomTextFormField(
                hintText: '이름, 전화번호, 차량번호로 검색해주세요',
                prefixIcon: Icon(
                  CupertinoIcons.search,
                ),
                onChanged: (value) {
                  print('object');
                }),
          ),
        ));
  }
}
