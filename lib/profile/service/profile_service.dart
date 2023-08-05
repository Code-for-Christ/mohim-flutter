import 'package:dio/dio.dart';
import 'package:phonebook/common/config/config.dart';
import 'package:phonebook/common/dio/dio.dart';
import 'package:phonebook/common/model/church_member.dart';
import 'package:phonebook/group/model/ministry_role.dart';

class ProfileService {
  final url = '${Config.instance.baseUrl}/churches';

  Future<ChurchMember?> getMemberProfile(
      {required int churchId, required int memberId}) async {
    try {
      final dio = Dio();
      dio.interceptors.add(CustomInterceptor());
      final resp = await dio.get(
        '$url/$churchId/members?member_id=$memberId',
        options: Options(
          headers: {
            'content-type': 'application/json',
            'accessToken': 'true',
          },
        ),
      );
      final profile = ChurchMember.fromJson(resp.data['church_members'][0]);
      return profile;
    } catch (e) {
      return null;
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
      return [];
    }
  }
}
