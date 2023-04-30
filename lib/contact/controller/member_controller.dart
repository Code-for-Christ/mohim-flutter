import 'package:get/get.dart';
import 'package:phonebook/common/const/data.dart';
import 'package:phonebook/common/model/church_member.dart';
import 'package:phonebook/contact/service/member_service.dart';
import 'package:phonebook/user/controller/auth_controller.dart';

class MemberController extends GetxController {
  int page = 1;
  int size = 20;
  final nextData = true.obs;

  final profileImageUrl = ''.obs;
  final authCtrl = Get.find<AuthController>();

  final churchMembers = <ChurchMember>[].obs;
  final searchResultMembers = <ChurchMember>[].obs;
  final memberService = MemberService();

  // getter 추가로 인스턴스 불러오기
  static MemberController get to => Get.find();

  @override
  void onInit() {
    // getChuchMembers();
    super.onInit();
  }

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
}
