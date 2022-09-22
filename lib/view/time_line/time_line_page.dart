import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:twitter/model/account.dart';
import 'package:twitter/model/post.dart';
import 'package:twitter/view/time_line/post_page.dart';

class TimeLinePage extends StatefulWidget {
  const TimeLinePage({Key? key}) : super(key: key);

  @override
  State<TimeLinePage> createState() => _TimeLinePageState();
}

class _TimeLinePageState extends State<TimeLinePage> {
  Account myAccount = Account(
      id: '1',
      name: 'Flutterラボ',
      selfIntroduction: 'こんばんは',
      userId: 'flutter_labo',
      imagePath:
          'https://cdn-ak.f.st-hatena.com/images/fotolife/h/hikiniku0115/20190806/20190806000644.png',
      createdTime: DateTime.now(),
      updatedTime: DateTime.now());

  List<Post> postList = [
    Post(
        id: '1',
        content: '初めまして',
        postAccountId: 'id',
        createdTime: DateTime.now()),
    Post(
        id: '2',
        content: '初めまして2',
        postAccountId: 'id',
        createdTime: DateTime.now()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'タイムライン',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 2,
      ),
      body: ListView.builder(
        itemCount: postList.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
                border: index == 0
                    ? Border(
                        top: BorderSide(color: Colors.grey, width: 0),
                        bottom: BorderSide(color: Colors.grey, width: 0),
                      )
                    : Border(
                        bottom: BorderSide(color: Colors.grey, width: 0),
                      )),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  foregroundImage: NetworkImage(myAccount.imagePath),
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  myAccount.name,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  myAccount.userId,
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                            Text(DateFormat('M/d/yy')
                                .format(postList[index].createdTime!))
                          ],
                        ),
                        Text(postList[index].content)
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
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
