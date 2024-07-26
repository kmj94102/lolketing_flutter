import 'package:get/get.dart';
import 'package:lolketing_flutter/database/auth_database.dart';
import 'package:lolketing_flutter/model/login_model.dart';
import 'package:lolketing_flutter/network/auth_service.dart';
import 'package:lolketing_flutter/ui/home.dart';
import 'package:lolketing_flutter/util/common.dart';

class AuthController extends GetxController {
  var isLoggedIn = false.obs;
  var isLoading = true.obs;
  LoginResult? _user;

  int? get id => _user?.id;

  String? get email => _user?.email;

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    final db = AuthDatabase();
    _user = await db.fetchUser();

    if (_user != null) {
      isLoggedIn.value = true;
    } else {
      isLoggedIn.value = false;
    }

    isLoading.value = false;
  }

  void login({
    required String id,
    required String password,
  }) async {
    try {
      AuthDatabase databaseClient = AuthDatabase();
      final result =
          await AuthService().emailLogin(LoginInfo(id: id, password: password));
      databaseClient.insertLoginInfo(result);
      _user = result;

      Get.offAll(const HomeScreen());
    } catch (e) {
      showSnackBar(message: e.toString());
    }
  }

  void join({required JoinInfo info}) async {
    try {
      await AuthService().join(info);
      showSnackBar(message: '회원 가입 완료');
      Get.back();
    } catch (e) {
      showSnackBar(message: e.toString());
    }
  }
}
