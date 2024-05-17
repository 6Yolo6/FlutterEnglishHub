import 'package:flutter_english_hub/model/EBooks.dart';
import 'package:flutter_english_hub/model/EBookSeries.dart';
import 'package:flutter_english_hub/model/EBookCategory.dart';
import 'package:flutter_english_hub/service/api_service.dart';
import 'package:get/get.dart';

class EBooksService extends GetxService {
  final ApiService apiService = Get.find<ApiService>();

  // 根据seriesId获取列表
  Future<List<EBooks>> getEBooksBySeriesId(int seriesId) async {
    try {
      final response = await apiService.dio
          .get('eBooks/getBySeriesId', queryParameters: {'seriesId': seriesId});

      print('电子书列表: ${response.data}');
      if (response.data['data'] != null) {
        return (response.data['data'] as List)
            .map((item) => EBooks.fromJson(item))
            .toList();
      } else {
        throw Exception('Failed to load eBooks');
      }
    } catch (e) {
      print('e: ${e}');
      throw e;
    }
  }

  // 获取最新5条电子书
  Future<List<EBooks>> getLatestEBooks() async {
    try {
      final response = await apiService.dio.get('eBooks/getTop5');

      print('最新电子书列表: ${response.data}');
      if (response.data != null && response.data['data'] != null) {
        return (response.data['data'] as List)
            .map((item) => EBooks.fromJson(item))
            .toList();
      } else {
        throw Exception('Failed to load eBooks');
      }
    } catch (e) {
      print('e: ${e}');
      throw e;
    }
  }

  // 根据categoryId查询电子书系列列表
  Future<List<EBookSeries>> getEBookSeriesByCategoryId(int categoryId) async {
    try {
      final response = await apiService.dio.get(
        'eBookSeries/getByCategoryId',
          queryParameters: {'categoryId': categoryId});

      print('电子书系列列表: ${response.data}');

      if (response.data['data'] != null) {
        return (response.data['data'] as List)
            .map((item) => EBookSeries.fromJson(item))
            .toList();
      } else {
        throw Exception('Failed to load eBook series');
      }
    } catch (e) {
      print('e: ${e}');
      throw e;
    }
  }

  // 查询所有电子书类别
  Future<List<EBookCategory>> getEBookCategory() async {
    try {
      final response = await apiService.dio.get('eBookCategory/getAll');

      print('电子书类别列表: ${response.data}');
      if (response.data['data'] != null) {
        return (response.data['data'] as List)
            .map((item) => EBookCategory.fromJson(item))
            .toList();
      } else {
        throw Exception('Failed to load eBook category');
      }
    } catch (e) {
      print('e: ${e}');
      throw e;
    }
  }
}
