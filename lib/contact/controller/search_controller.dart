import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:phonebook/contact/controller/member_controller.dart';
import 'package:phonebook/contact/service/search_service.dart';

class SearchController extends GetxController {
  final searchText = ''.obs; // Rx로 searchText를 관리
  final searchResult = ''.obs; // Rx로 searchResult를 관리
  late final TextEditingController searchTextEditController;
  final memberCtrl = Get.find<MemberController>();

  late final int churchId;

  final searchService = SearchService();

  SearchController(
      {required this.searchTextEditController, required this.churchId});

  @override
  void onInit() {
    // searchText의 변경을 구독하고, debounce를 적용하여 searchSubject에 값을 전달합니다.
    searchTextEditController.addListener(() {
      searchText.value = searchTextEditController.text;
    });
    debounce(searchText, (_) {
      searchMembers(searchText: _);
      print(searchText.value);
    }, time: Duration(milliseconds: 500));

    super.onInit();
  }

  Future<void> searchMembers({required String searchText}) async {
    final result = await searchService.searchMembers(
        churchId: churchId, searchText: searchText);
    memberCtrl.churchMembers.value = result;
  }
}
