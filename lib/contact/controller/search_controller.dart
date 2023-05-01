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
  int page = 2; // 검색시도시 항상 1번으로 검색
  int size = 20;
  final hasNextPage = false.obs;

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
      if (searchText.isNotEmpty) {
        searchMembers(searchText: _);
      } else {
        memberCtrl.searchResultMembers.value = [];
      }
    }, time: Duration(milliseconds: 350));

    super.onInit();
  }

  Future<void> searchMembers({required String searchText}) async {
    // 항상 1번 페이지로 검색
    final result = await searchService.searchMembers(
        churchId: churchId, searchText: searchText, page: 1, size: size);
    if (result['result']) {
      memberCtrl.searchResultMembers.value = result['members'];
      page = 2; // 검색후에는 page 초기화
      hasNextPage.value = result['nextUrl'] != null ? true : false;
    }
  }

  Future<void> loadMoreMembers() async {
    final result = await searchService.searchMembers(
        churchId: churchId, searchText: searchText, page: page, size: size);
    if (result['result']) {
      memberCtrl.searchResultMembers.addAll(result['members']);
      page++;
      hasNextPage.value = result['nextUrl'] != null ? true : false;
    }
  }
}
