import 'package:get/get.dart';
import 'package:phonebook/common/const/data.dart';
import 'package:phonebook/common/model/church_member.dart';
import 'package:phonebook/contact/service/member_service.dart';
import 'package:phonebook/user/controller/auth_controller.dart';

class MemberController extends GetxController {
  int page = 1;
  int size = 20;
  final profileImageUrl = ''.obs;
  final authCtrl = Get.find<AuthController>();

  final churchMembers = <ChurchMember>[].obs;
  final searchResultMembers = <ChurchMember>[].obs;
  final memberService = MemberService();

  @override
  void onInit() {
    getChuchMembers();
    super.onInit();
  }

  Future<bool> getChuchMembers() async {
    final result = await memberService.getChurchMembers(
        churchId: authCtrl.churchId, page: page, size: size);

    if (result.isNotEmpty) {
      churchMembers.addAll(result);
      page++;
      return true;
    }
    return false;
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
