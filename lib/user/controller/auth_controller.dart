import 'package:get/get.dart';
import 'package:phonebook/common/const/data.dart';
import 'package:phonebook/common/view/root_tab.dart';
import 'package:phonebook/user/service/auth_service.dart';
import 'package:phonebook/user/view/auth_branch_screen.dart';
import 'package:phonebook/user/view/authenticate_screen.dart';

class AuthController extends GetxController {
  final authService = AuthService();

  void checkToken() async {
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    if (accessToken != null) {
      final result = await authService.refreshToken();
      if (result) {
        final isAuthenticated = await checkAuth();
        if (isAuthenticated) {
          _moveToHome(1000);
        } else {
          Get.offAll(() => AuthenticateScreen());
        }
      } else {
        _deleteToken();
      }
    } else {
      _moveToAuthBranch(1000);
    }
  }

  void _deleteToken() async {
    await storage.deleteAll();
  }

  Future<void> signUp(String email, String password) async {
    final isSignUp = await authService.signUp(email, password);
    if (isSignUp) {
      login(email, password);
    }
  }

  Future<bool> login(String email, String password) async {
    final result = await authService.login(email, password);

    if (result) {
      final isAuthenticated = await checkAuth();
      if (isAuthenticated) {
        _moveToHome(0);
      } else {
        _moveToAuthenticate(0);
      }
    }
    return false;
  }

  Future<bool> checkAuth() async {
    return await authService.checkAuth();
  }

  Future<void> authenticate(
    int churchId,
    String name,
    String phoneNumber,
  ) async {
    final result = await authService.authenticate(churchId, name, phoneNumber);
    if (result) {
      Get.offAll(RootTab());
    }
  }

  void _moveToAuthBranch(int? delay) {
    Future.delayed(Duration(milliseconds: delay as int), () {
      Get.off(AuthBranchScreen());
    });
  }

  void _moveToHome(int? delay) {
    Future.delayed(Duration(milliseconds: delay as int), () {
      Get.offAll(() => RootTab());
    });
  }

  void _moveToAuthenticate(int? delay) {
    Future.delayed(Duration(milliseconds: delay as int), () {
      Get.offAll(() => AuthenticateScreen());
    });
  }
}
