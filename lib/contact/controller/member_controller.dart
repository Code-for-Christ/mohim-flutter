import 'package:get/get.dart';
import 'package:phonebook/common/model/church_member.dart';
import 'package:phonebook/contact/model/church_member_detail.dart';
import 'package:phonebook/contact/model/household.dart';
import 'package:phonebook/contact/service/member_service.dart';
import 'package:phonebook/group/model/ministry_role.dart';
import 'package:phonebook/user/controller/auth_controller.dart';

class MemberController extends GetxController {
  int page = 1;
  int size = 20;
  final nextData = true.obs;

  final profileImageUrl = ''.obs;
  final ministryRoles = <MinistryRole>[].obs;
  final isFetchingChurchMemberDetail = true.obs;

  final authCtrl = Get.find<AuthController>();

  final churchMembers = <ChurchMember>[].obs;
  final searchResultMembers = <ChurchMember>[].obs;
  final memberService = MemberService();

  final churchMemberDetail = ChurchMemberDetail(
          address: '',
          birthYear: 0,
          carNumber: '',
          cell: 0,
          cellId: 0,
          cellRole: '',
          chruchName: '',
          churchId: 0,
          gatheringId: 0,
          gatheringName: '',
          gatheringRole: '',
          household: [],
          householderId: 0,
          id: 0,
          ministries: [],
          name: '',
          parish: 0,
          parishRole: '',
          phoneNumber: '',
          positionId: 0,
          positionName: '',
          relationshipWithHouseholder: '',
          salvationDay: 0,
          salvationMonth: 0,
          salvationYear: 0,
          sex: '',
          thumbnail: '')
      .obs;

  // getter 추가로 인스턴스 불러오기
  static MemberController get to => Get.find();

  Future<void> getChuchMembers() async {
    final result = await memberService.getChurchMembers(
        churchId: authCtrl.churchId, page: page, size: size);

    if (result['result']) {
      churchMembers.addAll(result['members']);
      page++;
      nextData.value = result['next'] != null ? true : false;
    }
  }

  Future<void> getProfileImageUrl({required int memberId}) async {
    final result = await memberService.getProfileImageUrl(
        churchId: authCtrl.churchId, memberId: memberId);
    if (result != null) {
      profileImageUrl.value = result.replaceFirst('https', 'http');
    } else {
      profileImageUrl.value = '';
    }
  }

  // Future<void> getMinistryRole({required int memberId}) async {
  //   final result = await memberService.getMinistryRole(
  //       churchId: authCtrl.churchId, memberId: memberId);
  //   ministryRoles.value = result;
  //   isFetchingMinistryRoles.value = false;
  // }

  Future<void> getChurchMember({required int memberId}) async {
    final ChurchMemberDetail? result = await memberService.getChurchMember(
        churchId: authCtrl.churchId, memberId: memberId);
    churchMemberDetail.value = result!;
    isFetchingChurchMemberDetail.value = false;
  }
}
