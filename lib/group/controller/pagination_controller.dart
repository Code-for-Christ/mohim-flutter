import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phonebook/common/const/type.dart';
import 'package:phonebook/group/controller/group_controller.dart';
import 'package:phonebook/group/service/group_service.dart';
import 'package:phonebook/user/controller/auth_controller.dart';

class PaginationController extends GetxController {
  late final ScrollController scrollCtrl;
  late int id;
  final GroupService _groupService = GroupService();
  final GroupType type;
  int page = 2;
  int size = 20;
  final hasData = true.obs;
  PaginationController(
      {required this.scrollCtrl, required this.type, required this.id});

  @override
  void onInit() {
    scrollCtrl.addListener(() async {
      if (scrollCtrl.position.maxScrollExtent == scrollCtrl.position.pixels) {
        await _getChurchMembers();
      }
    });
    super.onInit();
  }

  Future<bool> _getChurchMembers() async {
    if (type == GroupType.cell) {
      final result = await _groupService.getCellMembers(
          churchId: AuthController.to.churchId,
          cellId: id,
          page: page,
          size: size);
      if (result['result']) {
        GroupController.to.cellMembers.addAll(result['members']);
        page++;
        hasData.value = result['next'] != null ? true : false;
      } else {
        return false;
      }
    }
    return false;
  }
}
