import 'package:flutter_english_hub/service/auth_service.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  // 监听登录状态
  var isLoading = false.obs;
  var isLoggedIn = false.obs;

  final AuthService authService = Get.find<AuthService>();

  // 调用登录接口
  void login(String username, String password) async {
    isLoading(true);

    try {
      isLoggedIn((await authService.loginService(username, password)) as bool?);
      // 成功登录后，跳转到home_navigation
      if (isLoggedIn.value) {
        Get.offAllNamed('/home_navigation');
      }
    } finally {
      isLoading(false);
    }
  }

  // 注册接口
  void register(String username, String password) async {
    isLoading(true);

    try {
      isLoggedIn((await authService.registerService(username, password)) as bool?);
      // 成功注册后，直接登录
      if (isLoggedIn.value) {
        login(username, password);
      }
    } finally {
      isLoading(false);
    }
  }
}
