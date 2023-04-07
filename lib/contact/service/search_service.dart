import 'package:dio/dio.dart';
import 'package:phonebook/common/const/data.dart';
import 'package:phonebook/common/dio/dio.dart';
import 'package:phonebook/common/model/church_member.dart';

class SearchService {
  final url = 'http://$ip/churches';

  Future<List<ChurchMember>> searchMembers(
      {required int churchId, required searchText}) async {
    try {
      final dio = Dio();
      dio.interceptors.add(CustomInterceptor());
      final resp = await dio.get(
        '$url/$churchId/members?search=$searchText',
        options: Options(
          headers: {
            'content-type': 'application/json',
            'accessToken': 'true',
          },
        ),
      );
      print(resp.data['church_members']);
      final members = ChurchMember.fromJsonList(resp.data['church_members']);
      return members;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
