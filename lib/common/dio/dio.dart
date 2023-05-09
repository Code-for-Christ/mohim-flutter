import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:phonebook/common/const/data.dart';
import 'package:phonebook/common/view/root_tab_static.dart';
import 'package:phonebook/user/view/auth_branch_screen.dart';

class CustomInterceptor extends Interceptor {
  // 1) 요청 보낼때
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    print('[REQ] [${options.method}] ${options.uri}');

    if (options.headers['accessToken'] == 'true') {
      options.headers.remove('accessToken');

      final token = await storage.read(key: ACCESS_TOKEN_KEY);

      options.headers.addAll({
        'Authorization': 'Bearer $token',
      });
    }

    if (options.headers['refreshToken'] == 'true') {
      options.headers.remove('refreshToken');

      final token = await storage.read(key: REFRESH_TOKEN_KEY);

      options.headers.addAll({
        'Authorization': 'Bearer $token',
      });
    }
    return super.onRequest(options, handler);
  }
  // 2) 응답 받을 때

  // 3) 에러가 났을 때
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    print('[ERR] [${err.requestOptions.method}] ${err.requestOptions.uri}');
    print(err.error);
    final isStatus403 = err.response?.statusCode == 403;
    final isPathRefresh = err.requestOptions.path ==
        'https://mohim-api.com/api/v1/auth/refresh-token';

    // 네트워크 오류일시에는 토큰을 삭제하지 않고 대기
    if (err.type == DioErrorType.connectTimeout ||
        err.type == DioErrorType.sendTimeout ||
        err.type == DioErrorType.other) {
      Get.snackbar('네트워크 연결오류', '네트워크를 연결해주세요');
    } else if (isStatus403 || isPathRefresh) {
      await storage.deleteAll();
      Get.snackbar('재로그인 필요', '모힘을 찾아주신지 오래되셨네요! 다시 로그인 해주세요');
      Get.offAll(AuthBranchScreen());
    }
    // 나머지 오류에는 재로그인 요청
    else {
      Get.rawSnackbar(
        message: err.response!.data['message'].toString(),
        animationDuration: Duration(milliseconds: 400),
      );
    }

    return handler.next(err);
  }
}
