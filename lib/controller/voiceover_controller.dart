import 'package:flutter_english_hub/model/Voiceover.dart';
import 'package:flutter_english_hub/service/voiceover_service.dart';
import 'package:get/get.dart';

class VoiceoverController extends GetxController {
  final VoiceoverService voiceoverService = Get.find<VoiceoverService>();
  var currentPage = 1.obs;
  var myPage = 1.obs;


  // 刷新句子用户配音
  Future<List<Voiceover>> refreshVoiceovers(int sentenceId) async {
    currentPage.value = 1;
    var result = await voiceoverService.getVoiceover(sentenceId, currentPage.value, 5);
    currentPage.value++;
    // print('result: ${result}');
    return result;
    
  }

  // 分页获取句子用户配音
  Future<List<Voiceover>> fetchVoiceovers(int sentenceId) async {
    var result = await voiceoverService.getVoiceover(sentenceId, currentPage.value, 5);
    currentPage.value++;
    return result;
  }

  // 分页获取我的配音
  Future<List<Voiceover>> fetchMyVoiceovers() async {
    var result = await voiceoverService.getMyVoiceover(myPage.value, 5);
    myPage.value++;
    return result;
  }

  // 刷新我的配音
  Future<List<Voiceover>> refreshMyVoiceovers() async {
    myPage.value = 1;
    var result = await voiceoverService.getMyVoiceover(myPage.value, 5);
    myPage.value++;
    return result;
  }
}
