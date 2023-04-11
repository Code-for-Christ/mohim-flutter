import 'package:dio/dio.dart';
import 'package:phonebook/common/const/data.dart';
import 'package:phonebook/common/dio/dio.dart';
import 'package:phonebook/common/model/church_member.dart';

class SearchService {
  final url = '$baseUrl/churches';

  Future<Map<String, dynamic>> searchMembers(
      {required int churchId, required searchText, required int page, required int size}) async {
    try {
      final dio = Dio();
      dio.interceptors.add(CustomInterceptor());
      final resp = await dio.get(
        '$url/$churchId/members?search=$searchText&page=$page&size=$size',
        options: Options(
          headers: {
            'content-type': 'application/json',
            'accessToken': 'true',
          },
        ),
      );
      print(resp.data['metadata']);
      final members = ChurchMember.fromJsonList(resp.data['church_members']);
      return {'result': true, 'members' : members, 'nextUrl' : resp.data['metadata']['next_url']};
    } catch (e) {
      print(e);
      return {'result' : false};
    }
  }

}
