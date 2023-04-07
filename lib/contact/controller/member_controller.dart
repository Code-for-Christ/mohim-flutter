import 'package:get/get.dart';
import 'package:phonebook/common/const/data.dart';
import 'package:phonebook/common/model/church_member.dart';
import 'package:phonebook/contact/service/member_service.dart';

class MemberController extends GetxController {
  int page = 1;
  int size = 20;
  late int churchId;
  late int memberId;
  final profileImageUrl = ''.obs;

  final churchMembers = <ChurchMember>[].obs;
  final memberService = MemberService();

  MemberController({required this.churchId, required this.memberId});

  @override
  void onInit() {
    getChuchMembers();
    super.onInit();
  }

  Future<void> getChuchMembers() async {
    churchMembers.value = await memberService.getChurchMembers(
        churchId: churchId, page: page, size: size);
    page++;
  }

  Future<void> getProfileImageUrl() async {
    final result = await memberService.getProfileImageUrl(
        churchId: churchId, memberId: memberId);
    if (result != null) {
      profileImageUrl.value = result.replaceFirst('https', 'http');
    } else {
      profileImageUrl.value = '';
    }
  }
}
