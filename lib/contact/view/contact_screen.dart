import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phonebook/common/component/custom_text_form_field.dart';
import 'package:phonebook/common/const/colors.dart';
import 'package:phonebook/common/const/style.dart';
import 'package:phonebook/common/component/contact_card.dart';
import 'package:phonebook/common/util/throttler.dart';
import 'package:phonebook/contact/controller/member_controller.dart';
import 'package:phonebook/contact/controller/search_controller.dart';
import 'package:phonebook/contact/util/debounce.dart';
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
  final ScrollController searchScrollCtrl = ScrollController();

  bool isSearching = false;

  final _debounce = Debounce(Duration(microseconds: 100));
  final _throttler = Throttler();

  @override
  void initState() {
    searchCtrl = Get.put(SearchController(
        searchTextEditController: searchTextEditController,
        churchId: authCtrl.churchId));
    scrollCtrl.addListener(() async {
      if (scrollCtrl.position.maxScrollExtent == scrollCtrl.position.pixels) {
        // final result = await memberCtrl.getChuchMembers();
        _debounce(() => memberCtrl.getChuchMembers());
      }
    });
    searchScrollCtrl.addListener(() {
      if (searchScrollCtrl.position.maxScrollExtent <=
          searchScrollCtrl.position.pixels) {
        // _debounce(() => searchCtrl.loadMoreMembers());
        _throttler.throttle(Duration(milliseconds: 1500), () {
          searchCtrl.loadMoreMembers();
        });
        // searchCtrl.loadMoreMembers();
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
        if (!isSearching && memberCtrl.searchResultMembers.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'asset/img/logo/mohim_logo.png',
                  color: GRAY_LOGO_COLOR,
                  width: MediaQuery.of(context).size.width / 2,
                ),
              ],
            ),
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
              controller: searchScrollCtrl,
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              itemBuilder: ((context, index) {
                if (index == memberCtrl.searchResultMembers.length) {
                  if (searchCtrl.hasNextPage.value) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return Container(); // 빈 컨테이너 반환
                  }
                }
                final member = memberCtrl.searchResultMembers[index];
                return ContactCard(
                  member: member,
                );
              }),
              separatorBuilder: ((context, index) {
                return Gap(10);
              }),
              itemCount: memberCtrl.searchResultMembers.length + 1);
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'asset/img/logo/mohim_logo.png',
                color: GRAY_LOGO_COLOR,
                width: MediaQuery.of(context).size.width / 2,
              ),
            ],
          ),
        );
      }),
    );
  }

  AppBar _appBar({required TextEditingController searchTextEditController}) {
    return AppBar(
        title: Text(
          '성도검색',
          style: titleTextStyle.copyWith(color: Colors.black, fontSize: 22),
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark),
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
