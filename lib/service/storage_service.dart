import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


class StorageService extends GetxService {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  
  // 获取token
  Future<String?> getToken() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString('authorization');
  }

  // 保存token
  Future<void> saveToken(String token) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setString('authorization', token);
  }

  // 清除token
  Future<void> clearToken() async {
    final SharedPreferences prefs = await _prefs;
    await prefs.remove('authorization');
  }
}