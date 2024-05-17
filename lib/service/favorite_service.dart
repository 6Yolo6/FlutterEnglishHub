import 'package:flutter_english_hub/model/favorite.dart';
import 'package:flutter_english_hub/service/api_service.dart';
import 'package:get/get.dart';

class FavoriteService extends GetxService {
  final ApiService apiService = Get.find<ApiService>();

  Future<bool> addFavorite(Favorite favorite) async {
    try {
      final response = await apiService.dio.post(
        'favorites/add',
        data: favorite.toJson(),
      );
      return response.statusCode == 200;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  Future<List<Favorite>> getFavoritesByUserId() async {
    try {
      final response = await apiService.dio.get(
        'favorites/list',
      );
      if (response.statusCode == 200) {
        return (response.data['data'] as List)
            .map((item) => Favorite.fromJson(item))
            .toList();
      } else {
        throw Exception('Failed to load favorites');
      }
    } catch (e) {
      print('Error: $e');
      throw e;
    }
  }

  Future<bool> deleteFavorite(int resourceId, String resourceType) async {
    try {
      final response = await apiService.dio.post(
        'favorites/delete',
        data: {
          'resourceId': resourceId,
          'resourceType': resourceType,
        },
      );
      return response.statusCode == 200;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }
}
