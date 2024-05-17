import 'package:flutter/material.dart';
import 'package:flutter_english_hub/controller/user_controller.dart';
import 'package:get/get.dart';

class UserProfilePage extends StatelessWidget {
  final UserController userController = Get.find<UserController>();

  UserProfilePage({Key? key}) : super(key: key);


  Future<void> _showUpdateDialog(String title, String initialValue, String key) async {
    String newValue = initialValue;
    await showDialog(
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          title: Text('更新$title'),
          content: TextField(
            onChanged: (value) {
              newValue = value;
            },
            controller: TextEditingController(text: initialValue),
          ),
          actions: [
            TextButton(
              child: Text('取消'),
              onPressed: () {
                Get.back();
              },
            ),
            TextButton(
              child: Text('确认'),
              onPressed: () {
                userController.updateUser({key: newValue});
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('个人资料'),
      ),
      body: Obx(() {
        if (userController.user.value == null) {
          return Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(userController.user.value!.avatar),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    child: GestureDetector(
                      onTap: () {
                        userController.uploadAvatar();
                      },
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(userController.user.value!.avatar),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    child: Text(
                      userController.user.value!.username,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              ListTile(
                title: Text('头像'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  userController.uploadAvatar();
                },
              ),
              ListTile(
                title: Text('昵称'),
                subtitle: Text(userController.user.value!.username),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  _showUpdateDialog('昵称', userController.user.value!.username, 'username');
                },
              ),
              ListTile(
                title: Text('邮箱'),
                subtitle: Text(userController.user.value!.email ?? '未绑定'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  _showUpdateDialog('邮箱', userController.user.value!.email ?? '', 'email');
                },
              ),
              ListTile(
                title: Text('手机号'),
                subtitle: Text(userController.user.value!.telephone ?? '未绑定'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  _showUpdateDialog('手机号', userController.user.value!.telephone ?? '', 'telephone');
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
