import 'package:flutter_english_hub/service/video_category_service.dart';
import 'package:get/get.dart';
import 'package:flutter_english_hub/model/VideoCategory.dart';

class VideoCategoryController extends GetxController {
  final VideoCategoryService wordBookCategoryService = Get.find<VideoCategoryService>();


  Future<List<VideoCategory>> fetchVideoCategory() async {
    var result = await wordBookCategoryService.getVideoCategory();
    return result;
  }
  
}