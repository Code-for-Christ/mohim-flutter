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
import 'package:phonebook/user/controller/auth_controller.dart';

class ContactScreen extends StatefulWidget {
  ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final MemberController memberCtrl = Get.put(MemberController());
  final AuthController authCtrl = Get.find<AuthController>();
  late final SearchController searchCtrl;

  final TextEditingController searchTextEditController =
      TextEditingController();

  final ScrollController scrollCtrl = ScrollController();

  bool isSearching = false;
  bool hasData = true;

  @override
  void initState() {
    searchCtrl = Get.put(SearchController(
        searchTextEditController: searchTextEditController,
        churchId: authCtrl.churchId));
    scrollCtrl.addListener(() async {
      if (scrollCtrl.position.maxScrollExtent == scrollCtrl.position.pixels) {
        final result = await memberCtrl.getChuchMembers();
        setState(() {
          hasData = result;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: INPUT_BG_COLOR,
      appBar: _appBar(searchTextEditController: searchTextEditController),
      body: Obx(() {
        if (memberCtrl.churchMembers.isEmpty) {
          return Center(
            child: CircularProgressIndicator(color: PRIMARY_COLOR),
          );
        }
        if (isSearching && memberCtrl.searchResultMembers.isEmpty) {
          return Center(
            child: Text(
              '검색결과가 없습니다',
              style: body1TextStyle.copyWith(fontWeight: FontWeight.w400),
            ),
          );
        }
        if (isSearching && memberCtrl.searchResultMembers.isNotEmpty) {
          return ListView.separated(
              controller: scrollCtrl,
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              itemBuilder: ((context, index) {
                final member = memberCtrl.searchResultMembers[index];
                return ContactCard(
                  member: member,
                );
              }),
              separatorBuilder: ((context, index) {
                return Gap(10);
              }),
              itemCount: memberCtrl.searchResultMembers.length);
        }
        return ListView.separated(
            controller: scrollCtrl,
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            itemBuilder: ((context, index) {
              if (index < memberCtrl.churchMembers.length) {
                final member = memberCtrl.churchMembers[index];
                return ContactCard(
                  member: member,
                );
              } else {
                return hasData
                    ? Center(child: CircularProgressIndicator())
                    : Container();
              }
            }),
            separatorBuilder: ((context, index) {
              return Gap(10);
            }),
            itemCount: memberCtrl.churchMembers.length + 1);
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
                onChanged: (value) {
                  if (value.isEmpty) {
                    setState(() {
                      isSearching = false;
                    });
                  } else {
                    setState(() {
                      isSearching = true;
                    });
                  }
                }),
          ),
        ));
  }
}
