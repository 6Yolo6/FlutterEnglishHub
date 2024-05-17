import 'package:flutter_english_hub/model/Videos.dart';
import 'package:flutter_english_hub/service/api_service.dart';
import 'package:get/get.dart';

class VideosService extends GetxService {
  final ApiService apiService = Get.find<ApiService>();

  // 根据categoryId获取视频列表
  Future<List<Videos>> getVideosByCategoryId(int categoryId) async {
    try {
      final response = await apiService.dio.get('videos/getByCategoryId',
          queryParameters: {'categoryId': categoryId});

      print('视频列表: ${response.data}');
      if (response.data['data'] != null) {
        return (response.data['data'] as List)
            .map((item) => Videos.fromJson(item))
            .toList();
      } else {
        throw Exception('Failed to load videos');
      }
    } catch (e) {
      print('e: ${e}');
      throw e;
    }
  }

  // 获取最新5条视频
  Future<List<Videos>> getLatestVideos() async {
    try {
      final response = await apiService.dio.get('videos/getTop5');

      print('最新视频列表: ${response.data}');
      if (response.data != null && response.data['data'] != null) {
        return (response.data['data'] as List)
            .map((item) => Videos.fromJson(item))
            .toList();
      } else {
        throw Exception('Failed to load videos');
      }
    } catch (e) {
      print('e: ${e}');
      throw e;
    }
  }

  // 分页获取视频列表
  Future<List<Videos>> getVideosPage(int pageNum, int pageSize) async {
    try {
      final response = await apiService.dio.get('videos/getPage',
          queryParameters: {
            'pageNum': pageNum, 
            'pageSize': pageSize
          });
      print('视频列表: ${response.data}');
      if (response.data != null && response.data['data'] != null) {
        return (response.data['data']['records'] as List)
            .map((item) => Videos.fromJson(item))
            .toList();
      } else {
        throw Exception('Failed to load videos');
      }
    } catch (e) {
      print('e: ${e}');
      throw e;
    }
  }
}
