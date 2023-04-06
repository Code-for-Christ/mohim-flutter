import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:phonebook/common/const/data.dart';
import 'package:phonebook/common/dio/dio.dart';
import 'package:phonebook/user/model/login_response.dart';

class AuthService {
  final url = "http://$ip/auth";

  Future<bool> signUp(String email, String password) async {
    try {
      final dio = Dio();
      final resp = await dio.post('$url/users',
          options: Options(headers: {'content-type': 'application/json'}),
          data: {
            'email': email,
            'password': password,
          });
      return true;
    } on DioError catch (e) {
      print(e.response!.data);
      Get.rawSnackbar(
        message: e.response!.data['message'].toString(),
        animationDuration: Duration(milliseconds: 400),
      );
      return false;
    }
  }

  login(String username, String password) async {
    try {
      print('$url/login');
      final dio = Dio();
      final resp = await dio.post(
        '$url/login',
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
        data: {
          'username': username,
          'password': password,
        },
      );
      final loginResponse = LoginResponse.fromJson(resp.data);
      await storage.write(
          key: ACCESS_TOKEN_KEY, value: loginResponse.accessToken);
      return true;
    } on DioError catch (e) {
      print('[GET] 로그인 에러 : ${e.response!.data}');
      Get.rawSnackbar(
        message: e.response!.data['message'].toString(),
        animationDuration: Duration(milliseconds: 400),
      );
      return false;
    }
  }

  Future<Map<String, dynamic>> checkAuth() async {
    try {
      final dio = Dio();
      final resp = await dio.get(url,
          options: Options(headers: {
            'Authorization':
                'Bearer ${await storage.read(key: ACCESS_TOKEN_KEY)}',
            'content-type': 'application/json'
          }));
      return {
        'result': resp.data['is_authenticated'],
        'churchId': resp.data['church_id'],
        'memberId': resp.data['church_member_id'],
      };
    } catch (e) {
      print('[GET] 인증여부확인 에러 : $e');
      return {'result': false};
    }
  }

  Future<bool> authenticate(
      int church_id, String name, String phone_number) async {
    try {
      final dio = Dio();
      final resp = await dio.post('$url/authenticate',
          options: Options(headers: {
            'Authorization':
                'Bearer ${await storage.read(key: ACCESS_TOKEN_KEY)}',
            'content-type': 'application/json'
          }),
          data: {
            'church_id': church_id,
            'name': name,
            'phone_number': phone_number,
          });
      return resp.data['is_authenticated'];
    } on DioError catch (e) {
      Get.rawSnackbar(
        message: e.response!.data['message'].toString(),
        animationDuration: Duration(milliseconds: 400),
      );
      return false;
    }
  }

  Future<bool> refreshToken() async {
    try {
      final dio = Dio();
      final resp = await dio.post('$url/refresh-token',
          options: Options(headers: {
            'content-type': 'application/json',
            'authorization':
                'Bearer ${await storage.read(key: ACCESS_TOKEN_KEY)}'
          }));
      print(resp.data);
      await storage.write(
          key: ACCESS_TOKEN_KEY, value: resp.data['access_token']);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> findPassword({required String email}) async {
    try {
      final dio = Dio();
      dio.interceptors.add(CustomInterceptor());
      await dio.post('$url/find-password',
          options: Options(
            headers: {'content-type': 'application/json'},
          ),
          data: {'email': email});
      Get.snackbar('임시코드전송', '해당 이메일에서 코드를 확인해주세요');
      return true;
    } on DioError catch (e) {
      Get.rawSnackbar(
        message: e.response!.data['message'].toString(),
        animationDuration: Duration(milliseconds: 400),
      );
      return false;
    }
  }

  Future<bool> changePassword({
    required String email,
    required String password,
    required String code,
  }) async {
    try {
      final dio = Dio();
      dio.interceptors.add(CustomInterceptor());
      final resp = await dio.post('$url/change-password',
          options: Options(
            headers: {'content-type': 'application/json'},
          ),
          data: {
            "email": email,
            "password": password,
            "temporary_code": code,
          });
      Get.snackbar('비밀번호 변경', resp.data['message']);
      return true;
    } on DioError catch (e) {
      Get.rawSnackbar(
        message: e.response!.data['message'].toString(),
        animationDuration: Duration(milliseconds: 400),
      );
      return false;
    }
  }
}
