import 'package:flutter/material.dart';
import 'package:twitter/view/screen.dart';
import 'package:twitter/view/start_up/login_page.dart';
import 'package:twitter/view/time_line/time_line_page.dart';

void main() {
  runApp(const MyApp());
}

// Screenを読み込む
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginPage());
  }
}
