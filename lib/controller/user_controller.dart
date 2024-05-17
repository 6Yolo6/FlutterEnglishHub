import 'package:flutter/material.dart';
import 'package:flutter_english_hub/model/User.dart';
import 'package:flutter_english_hub/service/auth_service.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:dio/dio.dart' as dio;

class UserController extends GetxController {
  final AuthService authService = Get.find<AuthService>();
  final ImagePicker _picker = ImagePicker();

  var user = Rxn<User>();

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    await authService.fetchUserById();
    user.value = authService.user.value;
  }

  Future<void> uploadAvatar() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      File file = File(image.path);
      // 上传文件到服务器并获取新的URL
      try {
        final response = await authService.apiService.dio.post(
          'user/uploadAvatar',
          data: dio.FormData.fromMap({
            'file': await dio.MultipartFile.fromFile(file.path),
            'id': user.value?.id,
          }),
        );
        if (response.statusCode == 200) {
          final String newAvatarUrl = response.data['data'];
          user.update((val) {
            val?.avatar = newAvatarUrl;
          });
          // 更新用户信息
          await updateUser({'avatar': newAvatarUrl});
        } else {
          authService.showFeedback('Error', 'Failed to upload avatar', Colors.red);
        }
      } catch (e) {
        authService.showFeedback('Error', 'An error occurred', Colors.red);
      }
    }
  }

  Future<void> updateUser(Map<String, String> updates) async {
    User updatedUser = await authService.updateUser(updates);
    user.value = updatedUser;
  }
}
