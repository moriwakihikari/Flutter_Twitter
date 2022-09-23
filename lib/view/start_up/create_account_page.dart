import 'package:flutter/material.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({Key? key}) : super(key: key);

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  TextEditingController nameCountroller = TextEditingController();
  TextEditingController userIdCountroller = TextEditingController();
  TextEditingController selfIntroductionCountroller = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passCountroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          '新規作成',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(children: [
            SizedBox(height: 30),
            CircleAvatar(
              radius: 40,
              child: Icon(Icons.add),
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
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                if (nameCountroller.text.isNotEmpty &&
                    userIdCountroller.text.isNotEmpty &&
                    selfIntroductionCountroller.text.isNotEmpty &&
                    emailController.text.isNotEmpty &&
                    passCountroller.text.isNotEmpty) {}
              },
              child: Text('アカウントを作成'),
            )
          ]),
        ),
      ),
    );
  }
}
