import 'package:dio/dio.dart';
import 'package:phonebook/common/const/data.dart';
import 'package:phonebook/common/dio/dio.dart';
import 'package:phonebook/common/model/church_member.dart';
import 'package:phonebook/contact/model/church_member_detail.dart';
import 'package:phonebook/group/model/ministry_role.dart';

class MemberService {
  final url = '$baseUrl/churches';

  Future<Map<String, dynamic>> getChurchMembers({
    required int churchId,
    required int page,
    required int size,
  }) async {
    try {
      final dio = Dio();
      dio.interceptors.add(CustomInterceptor());
      final resp = await dio.get(
        '$url/$churchId/members?page=$page&size=$size',
        options: Options(
          headers: {'content-type': 'application/json', 'accessToken': 'true'},
        ),
      );
      List<ChurchMember> churchMembers =
          ChurchMember.fromJsonList(resp.data['church_members']);
      return {
        'result': true,
        'members': churchMembers,
        'next': resp.data['metadata']['next_url']
      };
    } catch (e) {
      return {'result': false};
    }
  }

  Future<String?> getProfileImageUrl({
    required int churchId,
    required int memberId,
  }) async {
    try {
      final dio = Dio();
      dio.interceptors.add(CustomInterceptor());
      final resp = await dio.get(
        '$url/$churchId/members/$memberId/profile-image-url',
        options: Options(
          headers: {
            'conten-type': 'application/json',
            'accessToken': 'true',
          },
        ),
      );
      final String imageUrl = resp.data['profile_image_url'];
      return imageUrl;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<MinistryRole>> getMinistryRole({
    required int churchId,
    required int memberId,
  }) async {
    try {
      final dio = Dio();
      dio.interceptors.add(CustomInterceptor());
      final resp = await dio.get(
        '$url/$churchId/members/$memberId/ministry-role',
        options: Options(
          headers: {
            'content-type': 'application/json',
            'accessToken': 'true',
          },
        ),
      );
      final role = MinistryRole.fromJsonList(resp.data['ministry_roles']);
      return role;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<ChurchMemberDetail?> getChurchMember(
      {required int churchId, required int memberId}) async {
    try {
      final dio = Dio();
      dio.interceptors.add(CustomInterceptor());
      final resp = await dio.get(
        'http://127.0.0.1:8000/api/v1/churches/$churchId/members/$memberId',
        options: Options(
          headers: {
            'content-type': 'application/json',
            'accessToken': 'true',
          },
        ),
      );
      final churchMemberDetail = ChurchMemberDetail.fromJson(resp.data);
      return churchMemberDetail;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
