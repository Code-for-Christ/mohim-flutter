import 'package:get/get.dart';
import 'package:phonebook/common/model/church_member.dart';
import 'package:phonebook/group/model/ministry_role.dart';
import 'package:phonebook/profile/service/profile_service.dart';
import 'package:phonebook/user/controller/auth_controller.dart';

class ProfileController extends GetxController {
  final authCtrl = Get.find<AuthController>();

  final ministryRoles = <MinistryRole>[].obs;

  final imageUrl = ''.obs;
  final member = ChurchMember(
          id: 0,
          name: '',
          thumbnail: '',
          gatheringId: -1,
          householderId: -1,
          birthYear: null,
          salvationYear: null,
          salvationMonth: null,
          salvationDay: null,
          carNumber: null,
          sex: '',
          phoneNumber: 'phoneNumber',
          address: 'address',
          cell: -1,
          cellId: -1,
          chruchName: 'chruchName',
          churchId: -1,
          gatheringName: 'gatheringName',
          relationshipWithHouseholder: 'relationshipWithHouseholder')
      .obs;

  final profileService = ProfileService();

  @override
  void onInit() {
    getMemberProfile();
    getProfileImageUrl();
    getMinistryRole();
    super.onInit();
  }

  Future<void> getMemberProfile() async {
    final result = await profileService.getMemberProfile(
        churchId: authCtrl.churchId, memberId: authCtrl.memberId);
    if (result != null) {
      member.value = result;
    }
  }

  Future<void> getProfileImageUrl() async {
    final result = await profileService.getProfileImageUrl(
        churchId: authCtrl.churchId, memberId: authCtrl.memberId);
    if (result != null) {
      imageUrl.value = result.replaceFirst('https', 'http');
    } else {
      imageUrl.value = '';
    }
  }

  Future<void> getMinistryRole() async {
    final result = await profileService.getMinistryRole(
        memberId: authCtrl.memberId, churchId: authCtrl.churchId);
    ministryRoles.value = result;
  }
}
