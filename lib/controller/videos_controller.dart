import 'package:flutter_english_hub/model/Videos.dart';
import 'package:flutter_english_hub/service/videos_service.dart';
import 'package:get/get.dart';

class VideosController extends GetxController {
  final VideosService videosService = Get.find<VideosService>();
  var videosList = <Videos>[].obs;
  var currentPage = 1.obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchVideos();
    super.onInit();
  }

  Future<void> fetchVideos() async {
    if (isLoading.value) return;

    try {
      isLoading(true);
      var result = await videosService.getVideosPage(currentPage.value, 10);
      videosList.addAll(result);
      currentPage.value++;
    } finally {
      isLoading(false);
    }
  }

  Future<void> refreshVideos() async {
    try {
      isLoading(true);
      currentPage.value = 1;
      var result = await videosService.getVideosPage(currentPage.value, 10);
      videosList.assignAll(result);
      currentPage.value++;
    } finally {
      isLoading(false);
    }
  }

  // 根据categoryId获取视频列表
  Future<List<Videos>> getVideosByCategoryId(int categoryId) async {
    var result = await videosService.getVideosByCategoryId(categoryId);
    return result;
  }


  // 获取最新5条视频
  Future<List<Videos>> getLatestVideos() async {
    var result = await videosService.getLatestVideos();
    return result;
  }

  // 分页获取视频列表
  Future<List<Videos>> getVideosPage() async {
    var result = await videosService.getVideosPage(currentPage.value, 10);
    currentPage.value++;
    return result;
  }
}
