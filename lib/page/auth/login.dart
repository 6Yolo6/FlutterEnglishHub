// ignore_for_file: constant_identifier_names

import "package:flutter/material.dart";
import 'package:flutter_english_hub/controller/auth_controller.dart';
import 'package:flutter_english_hub/main.dart';
import 'package:flutter_english_hub/page/auth/forgot_password.dart';
import 'package:get/get.dart';
import 'package:flutter_english_hub/page/auth/sign_up.dart';
import 'package:flutter_english_hub/theme/login_theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // 用户名和密码输入框控制器
  final userController = TextEditingController();
  final passwordController = TextEditingController();
  // 登录控制器
  final AuthController authController = Get.find<AuthController>();
  // 添加全局FormKey，用于校验输入
  final _formKey = GlobalKey<FormState>();
  // 是否隐藏密码
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    Get.find<MyApp>().setShouldShowFloatingButton(false, context);
    // 返回一个Scaffold，是Material库中提供的页面脚手架
    return Scaffold(
      body: Container(
        // padding上边距
        padding: const EdgeInsets.only(top: 44.0),
        // 背景渐变色
        decoration: const BoxDecoration(gradient: SIGNUP_BACKGROUND),
        // ListView是一个可以垂直滚动的列表
        child: Form(
          key: _formKey,
          child: ListView(
            // 滚动效果
            physics: const BouncingScrollPhysics(),
            children: <Widget>[
              Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 200.0,
                  height: 200.0,
                  fit: BoxFit.cover,
                ),
              ),
              headlinesWidget(),
              userNameTextFieldWidget(),
              passwordTextFieldWidget(),
              loginButtonWidget(),
              signupWidget()
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // 释放资源
    userController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _passwordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  // 密码输入框
  Widget passwordTextFieldWidget() {
    return Container(
      margin: const EdgeInsets.only(left: 32.0, right: 16.0),
      child: TextFormField(
        // 密码输入框控制器
        controller: passwordController,
        style: hintAndValueStyle,
        // 是否隐藏输入内容
        obscureText: _obscureText,
        decoration: InputDecoration(
          suffixIcon: GestureDetector(
            onTap: _passwordVisibility,
            child: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
              color: Color(0xff35AA90),
              size: 30.0,
            ),
          ),
            fillColor: const Color(0x3305756D),
            filled: true,
            contentPadding: const EdgeInsets.fromLTRB(40.0, 30.0, 10.0, 10.0),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide.none),
            hintText: 'Password',
            hintStyle: hintAndValueStyle),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '密码不能为空';
          }
          return null;
        },
      ),
    );
  }

  // 用户名输入框
  Widget userNameTextFieldWidget() {
    return Container(
      margin: const EdgeInsets.only(left: 16.0, right: 32.0, top: 32.0),
      decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
                color: Colors.black12,
                blurRadius: 15,
                spreadRadius: 0,
                offset: Offset(0.0, 16.0)),
          ],
          borderRadius: BorderRadius.circular(12.0),
          gradient: const LinearGradient(
              begin: FractionalOffset(0.0, 0.4),
              end: FractionalOffset(0.9, 0.7),
              stops: [
                0.2,
                0.9
              ],
              colors: [
                Color(0xffFFC3A0),
                Color(0xffFFAFBD),
              ])),
      // 添加Form表单，用于校验输入
      child: TextFormField(
        // 用户名输入框控制器
        controller: userController,
        style: hintAndValueStyle,
        decoration: InputDecoration(
            suffixIcon: const Icon(Icons.person,
                color: Color(0xff35AA90), size: 30.0),
            contentPadding: EdgeInsets.fromLTRB(40.0, 30.0, 10.0, 10.0),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide.none),
            hintText: 'Username',
            hintStyle: hintAndValueStyle),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '用户名不能为空';
          }
          return null;
        },
      ),
    );
  }

  // 登录标题
  Widget headlinesWidget() {
    return Container(
      margin: const EdgeInsets.only(left: 48.0, top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'WELCOME TO ENGLISH HUB'.tr,
            textAlign: TextAlign.left,
            style: TextStyle(
                letterSpacing: 3,
                fontSize: 20.0,
                color: Get.theme.primaryColor,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold),
            
          ),
          Container(
            margin: const EdgeInsets.only(top: 48.0),
            child: Text(
              'Log in \nto continue'.tr,
              textAlign: TextAlign.left,
              style: TextStyle(
                letterSpacing: 3,
                fontSize: 32.0,
                color: Get.theme.primaryColor,
                fontFamily: 'Montserrat',
              ),
            ),
          )
        ],
      ),
    );
  }

  // 登录按钮
  Widget loginButtonWidget() {
    return Obx(() {
      if (authController.isLoading.value) {
        // 展示加载中
        return const CircularProgressIndicator();
      } else {
        // 展示登录按钮
        return Container(
          margin: const EdgeInsets.only(left: 32.0, top: 32.0),
          child: Row(
            children: <Widget>[
              InkWell(
                onTap: () {
                  // 校验输入
                  print('Login button pressed');
                  // 打印输入的用户名和密码
                  print('username: ${userController.text}');
                  print('password: ${passwordController.text}');
                  if (_formKey.currentState!.validate()) {
                  authController.login(
                      userController.text, passwordController.text);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 36.0, vertical: 16.0),
                  // 登录按钮样式
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 15,
                            spreadRadius: 0,
                            offset: Offset(0.0, 32.0)),
                      ],
                      borderRadius: new BorderRadius.circular(36.0),
                      // 渐变色
                      gradient: const LinearGradient(
                          begin: FractionalOffset.centerLeft,
                          stops: [
                            0.2,
                            1
                          ],
                          colors: [
                            Color(0xff000000),
                            Color(0xff434343),
                          ])),
                  child: Text(
                    'LOGIN'.tr,
                    style: TextStyle(
                        color: Color(0xffF1EA94),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat'),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  print('忘记密码');
                  // 跳转到忘记密码页面
                  Get.to(() => ForgotPasswordPage(), transition: Transition.fade, duration: Duration(seconds: 1));
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 36.0, vertical: 16.0),
                  margin: const EdgeInsets.only(left: 16.0),
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 15,
                            spreadRadius: 0,
                            offset: Offset(0.0, 32.0)),
                      ],
                      borderRadius: new BorderRadius.circular(36.0),
                      gradient: const LinearGradient(
                          begin: FractionalOffset.centerLeft,
                          stops: [
                            0.2,
                            1
                          ],
                          colors: [
                            Color(0xff000000),
                            Color(0xff434343),
                          ])),
                  child: Text(
                    'FORGOT PASSWORD'.tr,
                    style: TextStyle(
                        color: Color(0xffF1EA94),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat'),
                  ),
                ),
              )
            ],
          ),
        );
      }
    });
  }
}

// 跳转注册
Widget signupWidget() {
  return Container(
    margin: const EdgeInsets.only(left: 48.0, top: 32.0),
    child: Row(
      children: <Widget>[
        Text(
          'Don\'t have an account'.tr,
          style: TextStyle(
            fontFamily: 'Montserrat',
            color: Get.theme.primaryColor,
            ),
        ),
        TextButton(
          onPressed: () {
            print('Sign Up button pressed');
            Get.to(() => const SignUpPage(), transition: Transition.fade);
          },
          child: Text(
            'Sign Up'.tr,
            style: TextStyle(
                color: Color(0xff353535),
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat'),
          ),
        )
      ],
    ),
  );
}
