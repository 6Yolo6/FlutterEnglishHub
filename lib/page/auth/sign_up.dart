// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_english_hub/page/auth/login.dart';
import 'package:flutter_english_hub/theme/login_theme.dart';
import 'package:flutter_english_hub/controller/auth_controller.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // 用户名和密码输入框控制器
  final userController = TextEditingController();
  final passwordController = TextEditingController();
  // 登录控制器，
  final AuthController authController = Get.find<AuthController>();
  // 添加FormKey，用于校验输入
  final _userNameKey = GlobalKey<FormState>();
  final _passwordKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // 返回一个Scaffold，是Material库中提供的页面脚手架
    return Scaffold(
      body: Container(
        // padding上边距
        padding: const EdgeInsets.only(top: 64.0),
        // 背景渐变色
        decoration: const BoxDecoration(gradient: SIGNUP_BACKGROUND),
        // ListView是一个可以垂直滚动的列表
        child: ListView(
          // 滚动效果
          physics: const BouncingScrollPhysics(),
          children: <Widget>[
            Center(
              child: Image.asset(
                'assets/images/logo_signup.png',
                width: 100.0,
                height: 100.0,
                fit: BoxFit.cover,
              ),
            ),
            headlinesWidget(),
            userNameTextFieldWidget(),
            passwordTextFieldWidget(),
            signUpButtonWidget(),
            loginWidget()
          ],
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

  // 密码输入框
  Widget passwordTextFieldWidget() {
    return Container(
      margin: const EdgeInsets.only(left: 32.0, right: 16.0),
      child: Form(
        key: _passwordKey,
        child: TextFormField(
          // 密码输入框控制器
          controller: passwordController,
          style: hintAndValueStyle,
          // 隐藏输入内容
          obscureText: true,
          decoration: InputDecoration(
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
      child: Form(
        key: _userNameKey,
        child: TextFormField(
          // 用户名输入框控制器
          controller: userController,
          style: hintAndValueStyle,
          decoration: InputDecoration(
              suffixIcon: const Icon(IconData(0xe902, fontFamily: 'Icons'),
                  color: Color(0xff35AA90), size: 10.0),
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
      ),
    );
  }

  //  注册标题
  Widget headlinesWidget() {
    return Container(
      margin: const EdgeInsets.only(left: 48.0, top: 32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'WELCOME BACK!',
            textAlign: TextAlign.left,
            style: TextStyle(
                letterSpacing: 3,
                fontSize: 20.0,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold),
          ),
          Container(
            margin: const EdgeInsets.only(top: 48.0),
            child: const Text(
              'Sign Up \nto continue.',
              textAlign: TextAlign.left,
              style: TextStyle(
                letterSpacing: 3,
                fontSize: 32.0,
                fontFamily: 'Montserrat',
              ),
            ),
          )
        ],
      ),
    );
  }

  // 注册按钮
  Widget signUpButtonWidget() {
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
                  print('sign up button pressed');
                  // 打印输入的用户名和密码
                  print('username: ${userController.text}');
                  print('password: ${passwordController.text}');
                  // if (_formKey.currentState!.validate()) {
                  authController.register(
                      userController.text, passwordController.text);
                  // }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 36.0, vertical: 16.0),
                  // 按钮样式
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
                  child: const Text(
                    'REGISTER',
                    style: TextStyle(
                        color: Color(0xffF1EA94),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat'),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    });
  }
}

// 跳转登录
Widget loginWidget() {
  return Container(
    margin: const EdgeInsets.only(left: 48.0, top: 32.0),
    child: Row(
      children: <Widget>[
        const Text(
          'already have an account?',
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        TextButton(
          onPressed: () {
            print('login button pressed');
            Get.to(() => const SignUpPage(), transition: Transition.fade);
          },
          child: const Text(
            'Login',
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
