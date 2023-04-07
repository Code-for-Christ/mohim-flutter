import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:phonebook/common/model/church_member.dart';
import 'package:phonebook/group/model/ministry_role.dart';
import 'package:phonebook/profile/service/profile_service.dart';

class ProfileController extends GetxController {
  late int churchId;
  late int memberId;

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

  ProfileController({required this.churchId, required this.memberId});

  Future<void> getMemberProfile() async {
    final result = await profileService.getMemberProfile(
        churchId: churchId, memberId: memberId);
    if (result != null) {
      member.value = result;
    }
  }

  Future<void> getProfileImageUrl() async {
    final result = await profileService.getProfileImageUrl(
        churchId: churchId, memberId: memberId);
    if (result != null) {
      imageUrl.value = result.replaceFirst('https', 'http');
    } else {
      imageUrl.value = '';
    }
  }

  Future<void> getMinistryRole() async {
    final result = await profileService.getMinistryRole(
        memberId: memberId, churchId: churchId);
    ministryRoles.value = result;
  }
}
