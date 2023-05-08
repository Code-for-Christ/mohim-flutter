import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:phonebook/common/const/data.dart';
import 'package:phonebook/common/view/root_tab_static.dart';
import 'package:phonebook/user/service/auth_service.dart';
import 'package:phonebook/user/view/auth_branch_screen.dart';
import 'package:phonebook/user/view/authenticate_screen.dart';
import 'package:phonebook/user/view/change_password_screen.dart';

class AuthController extends GetxController {
  final authService = AuthService();

  int churchId = -1;
  int memberId = -1;
  String email = '';

  static AuthController get to => Get.find();

  void checkToken() async {
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    if (accessToken != null) {
      final result = await authService.refreshToken();
      if (result) {
        final auth = await checkAuth();
        if (auth['result']) {
          churchId = auth['churchId'];
          memberId = auth['memberId'];
          email = auth['email'];
          _moveToHome(0);
        } else {
          _moveToAuthenticate(0);
        }
      } else {
        // _deleteToken();
      }
    } else {
      _moveToAuthBranch(0);
    }
  }

  void _deleteToken() async {
    await storage.deleteAll();
  }

  // Future<void> _bindControllers({required Map<String, dynamic> auth}) async {
  //   Get.put(MemberController(
  //       churchId: auth['churchId'], memberId: auth['memberId']));
  //   Get.put(GroupController(
  //       churchId: auth['churchId'], memberId: auth['memberId']));
  // }

  Future<void> signUp(String email, String password) async {
    final isSignUp = await authService.signUp(email, password);
    if (isSignUp) {
      login(email, password);
    }
  }

  Future<bool> login(String email, String password) async {
    final result = await authService.login(email, password);

    if (result) {
      final auth = await checkAuth();
      if (auth['result']) {
        churchId = auth['churchId'];
        memberId = auth['memberId'];
        this.email = auth['email'];
        _moveToHome(0);
      } else {
        _moveToAuthenticate(0);
      }
    }
    return false;
  }

  void logout() {
    _deleteToken();
    _moveToAuthBranch(0);
  }

  Future<Map<String, dynamic>> checkAuth() async {
    return await authService.checkAuth();
  }

  Future<void> authenticate(
    int churchId,
    String name,
    String phoneNumber,
  ) async {
    final auth = await authService.authenticate(
        churchId: churchId, name: name, phoneNumber: phoneNumber);
    if (auth['result']) {
      this.churchId = auth['churchId'];
      memberId = auth['memberId'];
      email = auth['email'];
      _moveToHome(0);
    }
  }

  Future<void> findPassword({required String email}) async {
    final result = await authService.findPassword(email: email);
    if (result) {
      Get.to(
          ChangePasswordScreen(
            email: email,
          ),
          transition: Transition.cupertino);
    }
  }

  Future<void> changePassword(
      {required String email,
      required String password,
      required String code}) async {
    final result = await authService.changePassword(
        email: email, password: password, code: code);
    if (result) {
      Get.offAll(AuthBranchScreen(), transition: Transition.native);
    }
  }

  Future<void> deleteAccount() async {
    final result = await authService.deleteAccount(email: email);
    if (result) {
      Get.offAll(AuthBranchScreen());
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
