import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phonebook/common/const/type.dart';
import 'package:phonebook/common/util/throttler.dart';
import 'package:phonebook/group/controller/group_controller.dart';
import 'package:phonebook/group/service/group_service.dart';
import 'package:phonebook/user/controller/auth_controller.dart';

class PaginationController extends GetxController {
  late final ScrollController _scrollCtrl;
  late int id;
  final GroupService _groupService = GroupService();
  final GroupType _type;
  int page = 2;
  int size = 20;
  final _throttler = Throttler();

  PaginationController(
      {required ScrollController scrollCtrl,
      required GroupType type,
      required this.id})
      : _type = type,
        _scrollCtrl = scrollCtrl;

  @override
  void onInit() {
    _scrollCtrl.addListener(() {
      if (_scrollCtrl.position.maxScrollExtent <= _scrollCtrl.position.pixels) {
        _throttler.throttle(Duration(milliseconds: 2000), () async {
          await _getChurchMembers();
        });
      }
    });
    _scrollCtrl.toString();
    super.onInit();
  }

  Future<void> _getChurchMembers() async {
    if (_type == GroupType.cell) {
      final result = await _groupService.getCellMembers(
          churchId: AuthController.to.churchId,
          cellId: id,
          page: page,
          size: size);
      if (result['result']) {
        GroupController.to.cellMembers.addAll(result['members']);
        page++;
        GroupController.to.nextData.value =
            result['next'] != null ? true : false;
      }
    }
    if (_type == GroupType.gathering) {
      final result = await _groupService.getGatheringMembers(
          churchId: AuthController.to.churchId,
          gatheringId: id,
          page: page,
          size: size);
      if (result['result']) {
        GroupController.to.gatheringMembers.addAll(result['members']);
        page++;
        GroupController.to.nextData.value =
            result['next'] != null ? true : false;
      }
    }
  }
}
