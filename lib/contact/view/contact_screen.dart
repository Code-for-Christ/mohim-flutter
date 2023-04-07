import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phonebook/common/component/custom_text_form_field.dart';
import 'package:phonebook/common/const/colors.dart';
import 'package:phonebook/common/const/style.dart';
import 'package:phonebook/common/component/contact_card.dart';
import 'package:phonebook/contact/controller/member_controller.dart';
import 'package:phonebook/contact/controller/search_controller.dart';

class ContactScreen extends StatefulWidget {
  ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final MemberController memberCtrl = Get.find<MemberController>();

  late final SearchController searchCtrl;

  final TextEditingController searchTextEditController =
      TextEditingController();

  @override
  void initState() {
    searchCtrl = Get.put(SearchController(
        searchTextEditController: searchTextEditController,
        churchId: memberCtrl.churchId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: INPUT_BG_COLOR,
      appBar: _appBar(searchTextEditController: searchTextEditController),
      body: Obx(() {
        return memberCtrl.churchMembers.isNotEmpty
            ? ListView.separated(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                itemBuilder: ((context, index) {
                  final member = memberCtrl.churchMembers[index];
                  return ContactCard(
                    member: member,
                  );
                }),
                separatorBuilder: ((context, index) {
                  return Gap(10);
                }),
                itemCount: memberCtrl.churchMembers.length)
            : Center(
                child: CircularProgressIndicator(color: PRIMARY_COLOR),
              );
      }),
    );
  }

  AppBar _appBar({required TextEditingController searchTextEditController}) {
    return AppBar(
        title: Text(
          '연락처',
          style: titleTextStyle.copyWith(color: Colors.black, fontSize: 22),
        ),
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: Colors.transparent),
        centerTitle: false,
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: Size(double.infinity, 72),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: CustomTextFormField(
                controller: searchTextEditController,
                hintText: '이름, 전화번호, 차량번호로 검색해주세요',
                prefixIcon: Icon(
                  CupertinoIcons.search,
                ),
                onChanged: (value) {}),
          ),
        ));
  }
}
