import 'package:flutter_english_hub/page/auth/login.dart';
import 'package:flutter_english_hub/service/auth_service.dart';
import 'package:flutter_english_hub/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer(
      {Key? key,
      this.screenIndex,
      this.iconAnimationController,
      this.callBackIndex})
      : super(key: key);

  // 控制侧边栏顶部用户信息的动画
  final AnimationController? iconAnimationController;
  // 侧边栏当前选中的抽屉菜单项
  final DrawerIndex? screenIndex;
  // 侧边栏抽屉菜单项点击事件回调
  final Function(DrawerIndex)? callBackIndex;

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  List<DrawerList>? drawerList;
  @override
  void initState() {
    setDrawerListArray();
    super.initState();
  }

  // 初始化侧边栏抽屉菜单项
  void setDrawerListArray() {
    drawerList = <DrawerList>[
      // DrawerList(
      //   index: DrawerIndex.HOME,
      //   labelName: 'Home',
      //   icon: Icon(Icons.home),
      // ),
      DrawerList(
        index: DrawerIndex.Help,
        labelName: 'Help黄裕锋牛逼66',
        isAssetsImage: true,
        imageName: 'assets/images/supportIcon.png',
      ),
      DrawerList(
        index: DrawerIndex.FeedBack,
        labelName: 'FeedBack',
        icon: Icon(Icons.help),
      ),
      DrawerList(
        index: DrawerIndex.ChangeTheme,
        labelName: '更改主题',
        icon: Icon(Icons.brightness_6),
      ),
      DrawerList(
        index: DrawerIndex.ChangeLanguage,
        labelName: '更改语言',
        icon: Icon(Icons.language),
      ),
      DrawerList(
        index: DrawerIndex.Favorite,
        labelName: '我的收藏',
        icon: Icon(Icons.favorite),
      ),
      DrawerList(
        index: DrawerIndex.About,
        labelName: '关于我',
        icon: Icon(Icons.info),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // var brightness = MediaQuery.of(context).platformBrightness;
    // bool isLightMode = brightness == Brightness.light;
    return Scaffold(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      body: Obx(() {
        var user = Get.find<AuthService>().user.value;
        bool isLoggedIn = Get.find<AuthService>().isAuthenticated.value;
        return Column(
          // 侧边栏内容垂直排列
          crossAxisAlignment: CrossAxisAlignment.stretch,
          // 侧边栏内容主轴对齐方式，从头部开始
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 40.0),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    // 用户头像动画
                    AnimatedBuilder(
                      animation: widget.iconAnimationController!,
                      builder: (BuildContext context, Widget? child) {
                        // 缩放动画
                        return ScaleTransition(
                          scale: AlwaysStoppedAnimation<double>(1.0 -
                              (widget.iconAnimationController!.value) * 0.2),
                          child: RotationTransition(
                            turns: AlwaysStoppedAnimation<double>(Tween<double>(
                                        begin: 0.0, end: 24.0)
                                    .animate(CurvedAnimation(
                                        parent: widget.iconAnimationController!,
                                        curve: Curves.fastOutSlowIn))
                                    .value /
                                360),
                            child: Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: AppTheme.grey.withOpacity(0.6),
                                      offset: const Offset(2.0, 4.0),
                                      blurRadius: 8),
                                ],
                              ),
                              // 用户头像
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(Radius.circular(60.0)),
                                child: isLoggedIn 
                                  ? (user!.avatar.isNotEmpty 
                                    ? Image.network(user.avatar) 
                                    : Image.asset('assets/images/userImage.png')) 
                                  : Image.asset('assets/images/userImage.png'),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    // 用户名
                    Padding(
                      padding: const EdgeInsets.only(top: 8, left: 4),
                      child: Text(
                        isLoggedIn ? user!.username : 'Guest'.tr,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Get.theme.textTheme.headline6!.color,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Divider(
              height: 1,
              color: AppTheme.grey.withOpacity(0.6),
            ),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(0.0),
                itemCount: drawerList?.length,
                itemBuilder: (BuildContext context, int index) {
                  return inkwell(drawerList![index]);
                },
              ),
            ),
            Divider(
              height: 1,
              color: AppTheme.grey.withOpacity(0.6),
            ),
            Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    isLoggedIn ? 'Sign Out'.tr : 'Go to Login'.tr,
                    style: TextStyle(
                      fontFamily: 'WorkSans',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Get.theme.textTheme.headline6!.color,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  trailing: Icon(
                    isLoggedIn ? Icons.power_settings_new : Icons.login,
                    color: Get.theme.iconTheme.color, // 使用当前主题的图标颜色
                  ),
                  onTap: () {
                    if (isLoggedIn) {
                      SignOut();
                    } else {
                      GoToLogin();
                    }
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).padding.bottom,
                )
              ],
            ),
          ],
        );
      }),
    );
  }

  void SignOut() {
    print('sign out');
    Get.find<AuthService>().logout();
  }

  void GoToLogin() {
    print('go to login');
    Get.to(() => LoginPage(), transition: Transition.fade, duration: Duration(seconds: 1));
  }

  Widget inkwell(DrawerList listData) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.grey.withOpacity(0.1),
        highlightColor: Colors.transparent,
        onTap: () {
          navigationtoScreen(listData.index!);
        },
        child: Stack(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 6.0,
                    height: 46.0,
                    // decoration: BoxDecoration(
                    //   color: widget.screenIndex == listData.index
                    //       ? Colors.blue
                    //       : Colors.transparent,
                    //   borderRadius: new BorderRadius.only(
                    //     topLeft: Radius.circular(0),
                    //     topRight: Radius.circular(16),
                    //     bottomLeft: Radius.circular(0),
                    //     bottomRight: Radius.circular(16),
                    //   ),
                    // ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  listData.isAssetsImage
                      ? Container(
                          width: 24,
                          height: 24,
                          child: Image.asset(listData.imageName,
                              color: widget.screenIndex == listData.index
                                  ? Colors.blue
                                  : AppTheme.nearlyBlack),
                        )
                      : Icon(listData.icon?.icon,
                          color: widget.screenIndex == listData.index
                              ? Colors.blue
                              : AppTheme.nearlyBlack),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  Text(
                    listData.labelName,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: widget.screenIndex == listData.index
                          ? Colors.black
                          : AppTheme.nearlyBlack,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            widget.screenIndex == listData.index
                ? AnimatedBuilder(
                    animation: widget.iconAnimationController!,
                    builder: (BuildContext context, Widget? child) {
                      return Transform(
                        transform: Matrix4.translationValues(
                            (MediaQuery.of(context).size.width * 0.75 - 64) *
                                (1.0 -
                                    widget.iconAnimationController!.value -
                                    1.0),
                            0.0,
                            0.0),
                        child: Padding(
                          padding: EdgeInsets.only(top: 8, bottom: 8),
                          child: Container(
                            width:
                                MediaQuery.of(context).size.width * 0.75 - 64,
                            height: 46,
                            decoration: BoxDecoration(
                              color: Get.theme.iconTheme.color?.withOpacity(0.2),
                              borderRadius: new BorderRadius.only(
                                topLeft: Radius.circular(0),
                                topRight: Radius.circular(28),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(28),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }

  Future<void> navigationtoScreen(DrawerIndex indexScreen) async {
    widget.callBackIndex!(indexScreen);
  }
}

enum DrawerIndex {
  HOME,
  FeedBack,
  Help,
  Share,
  About,
  ForgettingCurve,
  Favorite,
  ChangeTheme,
  ChangeLanguage,
}

class DrawerList {
  DrawerList({
    this.isAssetsImage = false,
    this.labelName = '',
    this.icon,
    this.index,
    this.imageName = '',
  });

  String labelName;
  Icon? icon;
  bool isAssetsImage;
  String imageName;
  DrawerIndex? index;
}
