import 'package:flutter/material.dart';
import 'package:twitter/view/account/account_page.dart';
import 'package:twitter/view/time_line/post_page.dart';
import 'package:twitter/view/time_line/time_line_page.dart';

class Screen extends StatefulWidget {
  const Screen({Key? key}) : super(key: key);

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  // BottomNavigationBarItemの設定初期値0
  int selectedIndex = 0;
  // WidgetをListに入れる
  List<Widget> pageList = [TimeLinePage(), AccountPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bodyに別で作ったWidgetを入れる
      body: pageList[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.perm_identity_outlined), label: '')
        ],
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => PostPage()));
          },
          child: Icon(Icons.chat_bubble_outline)),
    );
  }
}
