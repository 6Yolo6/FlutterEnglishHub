import 'package:flutter/material.dart';
import 'package:flutter_english_hub/model/homelist.dart';
import 'package:flutter_english_hub/theme/app_theme.dart';
import 'package:get/get.dart';
import 'package:flutter_english_hub/controller/auth_controller.dart';


class GridViewPage extends StatelessWidget {
  const GridViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 获取AuthController
    Get.find<AuthController>();
    // 展示HomeList的内容
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Home"),
      // ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: HomeList.homeList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 一行显示两个元素
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 1.0,
        ),
        itemBuilder: (context, index) {
          final homeItem = HomeList.homeList[index];
          return GestureDetector(
            onTap: () {
              Get.toNamed(homeItem.routeName);
            },
            child: Container(
              decoration: BoxDecoration(
                color: AppTheme.nearlyWhite,
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    offset: const Offset(1.1, 1.1),
                    blurRadius: 10.0,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(homeItem.imagePath, fit: BoxFit.cover),
                  const SizedBox(height: 10),
                  Text(
                    homeItem.routeName.split('/').last, // 获取路由名称作为文本显示
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.grey.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
