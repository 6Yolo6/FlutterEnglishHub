import 'package:flutter_english_hub/controller/navigation_controller.dart';
import 'package:flutter_english_hub/main.dart';
import 'package:flutter_english_hub/page/introduction_animation/components/learning_resources_view.dart';
import 'package:flutter_english_hub/page/introduction_animation/components/center_next_button.dart';
import 'package:flutter_english_hub/page/introduction_animation/components/video_learning_view.dart';
import 'package:flutter_english_hub/page/introduction_animation/components/word_Look_up_view.dart';
import 'package:flutter_english_hub/page/introduction_animation/components/ready_view.dart';
import 'package:flutter_english_hub/page/introduction_animation/components/top_back_skip_view.dart';
import 'package:flutter_english_hub/page/introduction_animation/components/welcome_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_english_hub/service/storage_service.dart';
import 'package:get/get.dart';

class IntroductionAnimationScreen extends StatefulWidget {
  const IntroductionAnimationScreen({Key? key}) : super(key: key);

  @override
  _IntroductionAnimationScreenState createState() =>
      _IntroductionAnimationScreenState();
}

class _IntroductionAnimationScreenState
    extends State<IntroductionAnimationScreen> with TickerProviderStateMixin {
  AnimationController? _animationController;
  // 导航控制器
  final NavigationController controller = Get.find<NavigationController>();

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this, // 使用当前的 TickerProvider 作为动画控制器的 vsync
      duration: Duration(seconds: 8), // 动画持续时间为 8 秒
    );
    _animationController?.animateTo(0.0); // 将动画控制器的进度设置为 0
    super.initState(); 
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  // 构建整个动画引导界面
  @override
  Widget build(BuildContext context) {
    // 设置是否显示全局悬浮按钮为false
    Get.find<MyApp>().setShouldShowFloatingButton(false, context);
    // 打印动画控制器的值
    print("动画控制器的值: ${_animationController!.value}");
    return Scaffold(
      // 使用RGB(253,251,228)
      backgroundColor: Color(0xffFDFBE4),
      // backgroundColor: Color(0xffF7EBE1),
      body: ClipRect(
        child: Stack(
          children: [
            ReadyView(
              animationController: _animationController!,
            ),
            WordLookUpView(
              animationController: _animationController!,
            ),
            LearningResourcesView(
              animationController: _animationController!,
            ),
            VideoLearningView(
              animationController: _animationController!,
            ),
            WelcomeView(
              animationController: _animationController!,
            ),
            TopBackSkipView(
              onBackClick: _onBackClick, // 设置返回按钮的回调
              onSkipClick: _onSkipClick, // 设置跳过按钮的回调
              onGuestClick: _onGuestClick, // 设置游客按钮的回调
              animationController: _animationController!,
            ),
            CenterNextButton(
              animationController: _animationController!,
              onNextClick: _onNextClick,
            ),
          ],
        ),
      ),
    );
  }

  // 点击跳过按钮
  void _onSkipClick() {
    _animationController?.animateTo(0.8, // 跳转到 0.8 的动画进度
        duration: Duration(milliseconds: 1200)); // 持续时间为 1200 毫秒
  }

  // 点击游客按钮
  void _onGuestClick() {
    // 跳转到首页
    controller.changePage(0, _animationController!);
    // 更新标志位isFirstTime
    Get.find<StorageService>().saveIsFirstTime(false);
  }

  // 点击返回按钮，
  void _onBackClick() {
    if (_animationController!.value >= 0 &&
        _animationController!.value <= 0.2) {
      _animationController?.animateTo(0.0);
    } else if (_animationController!.value > 0.2 &&
        _animationController!.value <= 0.4) {
      _animationController?.animateTo(0.2);
    } else if (_animationController!.value > 0.4 &&
        _animationController!.value <= 0.6) {
      _animationController?.animateTo(0.4);
    } else if (_animationController!.value > 0.6 &&
        _animationController!.value <= 0.8) {
      _animationController?.animateTo(0.6);
    } else if (_animationController!.value > 0.8 &&
        _animationController!.value <= 1.0) {
      _animationController?.animateTo(0.8);
    }
  }

  void _onNextClick() {
    // 根据动画控制器的值，判断当前动画的进度，然后执行相应的动画
    if (_animationController!.value >= 0 &&
        _animationController!.value <= 0.2) {
      _animationController?.animateTo(0.4);
    } else if (_animationController!.value > 0.2 &&
        _animationController!.value <= 0.4) {
      _animationController?.animateTo(0.6);
    } else if (_animationController!.value > 0.4 &&
        _animationController!.value <= 0.6) {
      _animationController?.animateTo(0.8);
    } else if (_animationController!.value > 0.6 &&
        _animationController!.value <= 0.8) {
      _signUpClick();
    }
  }

  void _signUpClick() {
    // 跳转到注册页面
    Get.toNamed('/sign_up');
  }
}
