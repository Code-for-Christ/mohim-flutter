import 'package:dio/dio.dart';
import 'package:phonebook/common/const/data.dart';
import 'package:phonebook/user/model/church_model.dart';

class ChurchService {
  final url = "$baseUrl/churches";

  Future<List<ChurchModel>> getChurches() async {
    try {
      final dio = Dio();
      final resp = await dio.get(
        url,
        options: Options(headers: {
          'content-type': 'application/json',
          'Authorization':
              'Bearer ${await storage.read(key: ACCESS_TOKEN_KEY)}',
        }),
      );
      final churches = ChurchModel.fromJsonList(resp.data['churches']);
      return churches;
    } catch (e) {
      return [];
    }
  }
}
