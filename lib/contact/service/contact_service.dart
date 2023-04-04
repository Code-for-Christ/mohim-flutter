import 'package:dio/dio.dart';
import 'package:phonebook/common/const/data.dart';
import 'package:phonebook/contact/model/church_member.dart';

class ContactService {
  final url = 'http://$ip/churches';

  Future<List<ChurchMember>> getMembers() async {
    try {
      final dio = Dio();
      final resp = await dio.get(
        url,
      );
    } catch (e) {}
  }
}
