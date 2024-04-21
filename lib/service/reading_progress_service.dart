import 'package:flutter_english_hub/service/api_service.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

class ReadingProgressService extends GetxService {
  final ApiService apiService = Get.find<ApiService>();

  // Future<bool> saveProgress() async {
  //   try {
  //     final response = await apiService.dio.post(
  //     );
  //     if (response.statusCode == 200 && response.data['statusCode'] == '200') {
  //       Get.snackbar('Success', '阅读进度保存成功', backgroundColor: Colors.green);
  //       return true;
  //     } else {
  //       Get.snackbar('Error', 'Error saving progress: ${response.data['message']}', backgroundColor: Colors.red);
  //       return false;
  //     }
  //   } on dio.DioError catch (e) {
  //     print('Error saving progress: $e');
  //     return false;
  //   }
  // }

  // Future<Map<String, dynamic>?> getProgress(int userId, int eBookId) async {
  //   try {
  //     final response = await apiService.dio.get(
  //       'readingProgress/getProgress/$userId/$eBookId',
  //     );
  //     if (response.statusCode == 200 && response.data['statusCode'] == '200') {
  //       return response.data['data'];
  //     } else {
  //       Get.snackbar('Error', 'Error fetching progress: ${response.data['message']}', backgroundColor: Colors.red);
  //       return null;
  //     }
  //   } on dio.DioError catch (e) {
  //     print('Error fetching progress: $e');
  //     return null;
  //   }
  // }
}
