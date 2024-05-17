import 'package:flutter_english_hub/service/learning_plans_service.dart';
import 'package:get/get.dart';

class LearningPlansController extends GetxController {
  final LearningPlansService learningPlansService = Get.find<LearningPlansService>();

  // 保存或更新学习计划
  Future<bool> saveOrUpdateLearningPlan(int worBookId, int dailyNewWords, int dailyReviewWords, String endDate) async {
    var result = await learningPlansService.saveOrUpdateLearningPlan(worBookId, dailyNewWords, dailyReviewWords, endDate);
    return result;
  }
}