import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopBackSkipView extends StatelessWidget {
  final AnimationController animationController;
  // 返回和跳过按钮的回调函数
  final VoidCallback onBackClick;
  final VoidCallback onSkipClick;
  final VoidCallback onGuestClick;
  final VoidCallback onLanguageClick;

  const TopBackSkipView({
    Key? key,
    required this.onBackClick,
    required this.onSkipClick,
    required this.onGuestClick,
    required this.animationController,
    required this.onLanguageClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 定义一个从上到下滑动的动画
    final _animation =
        Tween<Offset>(begin: Offset(0, -1), end: Offset(0, 0)) // 动画从顶部滑入
            .animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(
        0.0,
        0.2,
        curve: Curves.fastOutSlowIn,
      ),
    ));

    // 定义一个从右侧滑出的动画，用于跳过按钮
    final _skipAnimation = Tween<Offset>(begin: Offset(4, 0), end: Offset(6, 0))
        .animate(CurvedAnimation(
      parent: animationController, // 使用传入的动画控制器
      curve: Interval(0.6, 0.8, curve: Curves.fastOutSlowIn), // 设置动画间隔和曲线
    ));

    // 定义游客按钮的滑动动画，从上到下滑入
    final _guestAnimation =
        Tween<Offset>(begin: Offset(2, 0), end: Offset(0, 0))
            .animate(CurvedAnimation(
      parent: animationController, // 使用传入的动画控制器
      curve: Interval(0.6, 0.8, curve: Curves.fastOutSlowIn), // 设置动画间隔和曲线
    ));

    // 使用 SlideTransition 让顶部导航栏进行滑动
    return Stack(
      children: [
        SlideTransition(
          position: _animation, // 应用上面定义的滑动动画
          child: Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top), // 确保导航栏不会被状态栏遮挡
            child: Container(
              height: 58, // 设置导航栏的高度
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 12), // 左右两侧的填充
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // 左右两侧对齐
                  children: [
                    // 返回按钮
                    IconButton(
                      onPressed: onBackClick,
                      icon: Icon(Icons.arrow_back_ios_new_rounded),
                    ),
                    // 跳过按钮
                    SlideTransition(
                      position: _skipAnimation,
                      child: IconButton(
                        onPressed: onSkipClick,
                        icon: Text('Skip'.tr),
                      ),
                    ),
                    // 游客按钮
                    SlideTransition(
                      position: _guestAnimation,
                      child: IconButton(
                        onPressed: onGuestClick,
                        icon: Text('Guest Access'.tr),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: IconButton(
            onPressed: onLanguageClick,
            icon: Icon(Icons.language),
          ),
        ),
      ),
      ],
    );
  }
}
