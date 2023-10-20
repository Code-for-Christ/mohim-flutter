import 'package:get/get.dart';
import 'package:phonebook/contact/model/church_member_detail.dart';
import 'package:phonebook/contact/service/member_service.dart';
import 'package:phonebook/user/controller/auth_controller.dart';

class ModalDetailController extends GetxController { 
  final memberService = MemberService();
  final authCtrl = Get.find<AuthController>();
  final profileImageUrl = ''.obs;
  final isFetchingChurchMemberDetail = true.obs;

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

  Future<void> _getProfileImageUrl({required int memberId}) async {
    final result = await memberService.getProfileImageUrl(
        churchId: authCtrl.churchId, memberId: memberId);
    if (result != null) {
      profileImageUrl.value = result.replaceFirst('https', 'http');
    } else {
      profileImageUrl.value = '';
    }
  }

  Future<void> _getChurchMember({required int memberId}) async {
    final ChurchMemberDetail? result = await memberService.getChurchMember(
        churchId: authCtrl.churchId, memberId: memberId);
    churchMemberDetail.value = result!;
    print(churchMemberDetail.value.phoneNumber);
    isFetchingChurchMemberDetail.value = false;
  }

  void loadData({required int memberId}) async { 
    await _getChurchMember(memberId: memberId);
    await _getProfileImageUrl(memberId: memberId);
    isFetchingChurchMemberDetail.value = false;
  }

  void deleteData(){
    isFetchingChurchMemberDetail.value = true;
    profileImageUrl.value = '';
    churchMemberDetail.value = ChurchMemberDetail(
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
          thumbnail: '');
  }
}