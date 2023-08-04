import 'package:get/get.dart';
import 'package:phonebook/common/model/church_member.dart';
import 'package:phonebook/group/model/gathering.dart';
import 'package:phonebook/group/model/ministry.dart';
import 'package:phonebook/group/model/ministry_member.dart';
import 'package:phonebook/group/model/position.dart';
import 'package:phonebook/group/service/group_service.dart';
import 'package:phonebook/user/controller/auth_controller.dart';

import '../model/cell.dart';

class GroupController extends GetxController {
  final authCtrl = Get.find<AuthController>();

  static GroupController get to => Get.find();

  // 그룹 서비스
  final groupService = GroupService();

  // 구역 탭
  final parishes = <int>[].obs;
  final parishLeaders = <ChurchMember>[].obs;
  final cells = <Cell>[].obs;
  final cellMembers = <ChurchMember>[].obs;
  final cellLeaders = <ChurchMember>[].obs;

  // 봉사 탭
  final ministries = <Ministry>[].obs;
  final ministryMembers = <MinistryMember>[].obs;

  // 회 탭
  final gatherings = <Gathering>[].obs;
  final gatheringMembers = <ChurchMember>[].obs;
  final gatheringLeaders = <ChurchMember>[].obs;

  // 직분 탭
  final positions = <Position>[].obs;
  final positionMembers = <ChurchMember>[].obs;

  // 페이지네이션
  int page = 1;
  int size = 20;
  final nextData = false.obs;
  @override
  void onInit() {
    getParishList();
    getCellList();
    getMinistryList();
    getGatheringList();
    getPositionList();
    super.onInit();
  }

  Future<void> getParishList() async {
    parishes.value =
        await groupService.getParishList(churchId: authCtrl.churchId);
  }

  Future<void> getCellList() async {
    cells.value = await groupService.getCellList(churchId: authCtrl.churchId);
  }

  Future<void> getCellMembers({
    required int cellId,
  }) async {
    final result = await groupService.getCellMembers(
        churchId: authCtrl.churchId, cellId: cellId, page: page, size: size);
    if (result['result']) {
      cellMembers.value = result['members'];
      nextData.value = result['next'] != null ? true : false;
    }
  }

  Future<void> getMinistryList() async {
    ministries.value =
        await groupService.getMinistryList(churchId: authCtrl.churchId);
  }

  Future<void> getGatheringList() async {
    gatherings.value =
        await groupService.getGatheringList(churchId: authCtrl.churchId);
  }

  Future<void> getPositionList() async {
    positions.value =
        await groupService.getPositionList(churchId: authCtrl.churchId);
  }

  Future<void> getMinistryMembers({
    required int ministryId,
  }) async {
    ministryMembers.value = await groupService.getMinistryMembers(
        churchId: authCtrl.churchId,
        ministryId: ministryId,
        page: page,
        size: size);
  }

  Future<void> getGatheringMembers({
    required int gatheringId,
  }) async {
    final result = await groupService.getGatheringMembers(
        churchId: authCtrl.churchId,
        gatheringId: gatheringId,
        page: page,
        size: size);
    if (result['result']) {
      gatheringMembers.value = result['members'];
      nextData.value = result['next'] != null ? true : false;
    }
  }

  Future<void> getPositionMembers({
    required int positionId,
  }) async {
    final result = await groupService.getPositionMembers(
        churchId: authCtrl.churchId,
        positionId: positionId,
        page: page,
        size: size);
    if (result['result']) {
      positionMembers.value = result['members'];
      nextData.value = result['next'] != null ? true : false;
    }
  }

  Future<void> getParishLeaders({required int parish}) async {
    parishLeaders.value = await groupService.getParishLeaders(
        churchId: authCtrl.churchId, parish: parish);
  }

  Future<void> getCellLeaders({required int cellId}) async {
    cellLeaders.value = await groupService.getCellLeaders(
        churchId: authCtrl.churchId, cellId: cellId);
  }

  Future<void> getGatheringLeaders({required int gatheringId}) async {
    gatheringLeaders.value = await groupService.getGatheringLeaders(
        churchId: authCtrl.churchId, gatheringId: gatheringId);
  }
}
