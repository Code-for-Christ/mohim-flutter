import 'package:dio/dio.dart';
import 'package:phonebook/common/const/data.dart';
import 'package:phonebook/common/dio/dio.dart';
import 'package:phonebook/common/model/church_member.dart';

class MemberService {
  final url = '$baseUrl/churches';

  Future<List<ChurchMember>> getChurchMembers({
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
      print(resp.data['metadata']);
      List<ChurchMember> churchMembers =
          ChurchMember.fromJsonList(resp.data['church_members']);
      return churchMembers;
    } catch (e) {
      print(e);
      return [];
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
}
