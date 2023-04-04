import 'package:get/get.dart';
import 'package:phonebook/common/model/church_member.dart';
import 'package:phonebook/contact/service/member_service.dart';

class MemberController extends GetxController {
  int page = 1;
  int size = 20;
  final profileImageUrl = ''.obs;
  
  final churchMembers = <ChurchMember>[].obs;
  final memberService = MemberService();

  @override
  void onInit() {
    getChuchMembers();
    super.onInit();
  }

  Future<void> getChuchMembers() async {
    churchMembers.value = await memberService.getChurchMembers(
        churchId: 1, page: page, size: size);
    page++;
  }

  Future<void> getProfileImageUrl({required int memberId}) async {
    final result =
        await memberService.getProfileImageUrl(churchId: 1, memberId: memberId);
    if (result != null) {
      profileImageUrl.value = result.replaceFirst('https', 'http');
    } else {
      profileImageUrl.value = '';
    }
  }
}
