
import 'package:flutter_english_hub/model/NewsHotwords.dart';
import 'package:flutter_english_hub/service/api_service.dart';
import 'package:get/get.dart';

class NewsHotwordsService extends GetxService {
  final ApiService apiService = Get.find<ApiService>();


  Future<List<NewsHotwords>> getPage(int pageNum, int pageSize) async {
    final response = await apiService.dio.get(
      'newsHotwords/getPage',
      queryParameters: {
        'pageNum': pageNum,
        'pageSize': pageSize,
      },
    );
    if (response.statusCode == 200) {
      var data = response.data['data']['records'];
      return data.map<NewsHotwords>((item) => NewsHotwords.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load hotwords');
    }
  }
}