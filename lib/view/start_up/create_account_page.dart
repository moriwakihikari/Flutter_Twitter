import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twitter/model/account.dart';
import 'package:twitter/utils/function_utils.dart';
import 'package:twitter/utils/authentication.dart';
import 'package:twitter/utils/firestore/users.dart';
import 'package:twitter/utils/widget_utils.dart';
import 'package:twitter/view/screen.dart';
import 'package:twitter/view/start_up/check_email_page.dart';

class CreateAccountPage extends StatefulWidget {
  final bool isSignInWithGoogle;
  CreateAccountPage({this.isSignInWithGoogle = false});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  TextEditingController nameCountroller = TextEditingController();
  TextEditingController userIdCountroller = TextEditingController();
  TextEditingController selfIntroductionCountroller = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passCountroller = TextEditingController();
  File? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetUtils.createAppBar('新規作成'),
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
                foregroundImage: image == null ? null : FileImage(image!),
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
            widget.isSignInWithGoogle
                ? Container()
                : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Container(
                          width: 300,
                          child: TextField(
                            controller: emailController,
                            decoration: InputDecoration(hintText: 'メールアドレス'),
                          ),
                        ),
                      ),
                      Container(
                        width: 300,
                        child: TextField(
                          controller: passCountroller,
                          decoration: InputDecoration(hintText: 'パスワード'),
                        ),
                      ),
                    ],
                  ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () async {
                if (nameCountroller.text.isNotEmpty &&
                    userIdCountroller.text.isNotEmpty &&
                    selfIntroductionCountroller.text.isNotEmpty &&
                    image != null) {
                  // if (widget.isSignInWithGoogle) {
                  //   var _result = await createAccount(
                  //       Authentication.currentFirebaseUser!.uid);
                  //   if (_result == true) {
                  //     await UserFirestore.getUser(
                  //         Authentication.currentFirebaseUser!.uid);
                  //     Navigator.pop(context);
                  //     Navigator.pushReplacement(context,
                  //         MaterialPageRoute(builder: (context) => Screen()));
                  //   }
                  // }
                  var result = await Authentication.signUp(
                      email: emailController.text, pass: passCountroller.text);
                  if (result is UserCredential) {
                    String imagePath = await FunctionUtils.uploadImage(
                        result.user!.uid, image!);
                    Account newAccount = Account(
                      id: result.user!.uid,
                      name: nameCountroller.text,
                      userId: userIdCountroller.text,
                      selfIntroduction: selfIntroductionCountroller.text,
                      imagePath: imagePath,
                    );
                    var _result = await UserFirestore.setUser(newAccount);
                    if (_result == true) {
                      result.user!.sendEmailVerification();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CheckEmailPage(
                                  email: emailController.text,
                                  pass: passCountroller.text)));
                    }
                  }
                }
              },
              child: Text('アカウントを作成'),
            )
          ]),
        ),
      ),
    );
  }

  // Future<dynamic> createAccount(String uid) async {
  //   String imagePath = await FunctionUtils.uploadImage(uid, image!);
  //   Account newAccount = Account(
  //     id: uid,
  //     name: nameCountroller.text,
  //     userId: userIdCountroller.text,
  //     selfIntroduction: selfIntroductionCountroller.text,
  //     imagePath: imagePath,
  //   );
  //   var _result = await UserFirestore.setUser(newAccount);
  // }
}
