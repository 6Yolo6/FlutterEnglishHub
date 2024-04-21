// ignore: file_names
import 'package:flutter_english_hub/model/user.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageService extends GetxService {
  final _storage = GetStorage();
  final _tokenKey = 'token';

  // 获取token
  String? getToken() {
    return _storage.read(_tokenKey);
  }

  // 保存token
  Future<void> saveToken(String token) async {
    await _storage.write(_tokenKey, token);
  }

  // 清除token
  Future<void> clearToken() async {
    await _storage.remove(_tokenKey);
  }

  // 保存是否第一次打开应用
  Future<void> saveIsFirstTime(bool isFirstTime) async {
    await _storage.write('isFirstTime', isFirstTime);
  }

  // 获取是否第一次打开应用
  bool? getIsFirstTime() {
    return _storage.read('isFirstTime');
  }

  // 保存用户信息
  Future<void> saveUser(data) async {
    await _storage.write('user', data);
  }

  // 获取用户信息
  User? getUser() {
    var userData = _storage.read('user');
    if (userData != null) {
      return User.fromJson(userData);
    }
    return null;
  }
}
