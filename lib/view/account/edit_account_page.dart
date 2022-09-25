import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twitter/model/account.dart';
import 'package:twitter/utils/authentication.dart';
import 'package:twitter/utils/firestore/users.dart';
import 'package:twitter/utils/function_utils.dart';
import 'package:twitter/utils/widget_utils.dart';
import 'package:twitter/view/start_up/login_page.dart';

class EditAccountPage extends StatefulWidget {
  const EditAccountPage({Key? key}) : super(key: key);

  @override
  State<EditAccountPage> createState() => _EditAccountPageState();
}

class _EditAccountPageState extends State<EditAccountPage> {
  Account myAccount = Authentication.myAccount!;
  TextEditingController nameCountroller = TextEditingController();
  TextEditingController userIdCountroller = TextEditingController();
  TextEditingController selfIntroductionCountroller = TextEditingController();
  File? image;

  ImageProvider getImage() {
    if (image == null) {
      return NetworkImage(myAccount.imagePath);
    } else {
      return FileImage(image!);
    }
  }

  @override
  void initState() {
    super.initState();
    nameCountroller = TextEditingController(text: myAccount.name);
    userIdCountroller = TextEditingController(text: myAccount.userId);
    selfIntroductionCountroller =
        TextEditingController(text: myAccount.selfIntroduction);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetUtils.createAppBar('プロフィール編集'),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(children: [
            SizedBox(height: 30),
            GestureDetector(
              onTap: () async {
                var result = await FunctionUtils.getImageFromGallery();
                if (result != null) {
                  setState(() {
                    image = File(result.path);
                  });
                }
              },
              child: CircleAvatar(
                foregroundImage: getImage(),
                radius: 40,
                child: Icon(Icons.add),
              ),
            ),
            Container(
              width: 300,
              child: TextField(
                controller: nameCountroller,
                decoration: InputDecoration(hintText: '名前'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Container(
                width: 300,
                child: TextField(
                  controller: userIdCountroller,
                  decoration: InputDecoration(hintText: 'ユーザーID'),
                ),
              ),
            ),
            Container(
              width: 300,
              child: TextField(
                controller: selfIntroductionCountroller,
                decoration: InputDecoration(hintText: '自己紹介'),
              ),
            ),
            SizedBox(height: 50),
            ElevatedButton(
                onPressed: () async {
                  if (nameCountroller.text.isNotEmpty &&
                      userIdCountroller.text.isNotEmpty &&
                      selfIntroductionCountroller.text.isNotEmpty) {
                    String imagePath = '';
                    if (image == null) {
                      imagePath = myAccount.imagePath;
                    } else {
                      var result =
                          await FunctionUtils.uploadImage(myAccount.id, image!);
                      imagePath = result;
                    }
                    Account updateAccount = Account(
                      id: myAccount.id,
                      name: nameCountroller.text,
                      userId: userIdCountroller.text,
                      selfIntroduction: selfIntroductionCountroller.text,
                      imagePath: imagePath,
                    );
                    Authentication.myAccount = updateAccount;
                    var result = await UserFirestore.updateUser(updateAccount);
                    if (result == true) {
                      Navigator.pop(context, true);
                    }
                  }
                },
                child: Text('更新')),
            SizedBox(height: 50),
            ElevatedButton(
                onPressed: () {
                  Authentication.signOut();
                  while (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                child: Text('ログアウト')),
            SizedBox(height: 50),
            ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.red),
                onPressed: () {
                  UserFirestore.deleteUser(myAccount.id);
                  Authentication.deleteAuth();
                  while (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                child: Text('アカウントを削除'))
          ]),
        ),
      ),
    );
  }
}
