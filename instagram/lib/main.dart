import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      theme: ThemeData(
        iconTheme: IconThemeData(color: Colors.black), // 아이콘의 기본 색상을 지정
        appBarTheme: AppBarTheme(
          color: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.black,
            size: 40
          ), // AppBar 내의 아이콘 색상을 지정
        ),
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Colors.black), // 기본 텍스트 스타일을 지정
        ),
      )
,
    home: const MyApp()
  ));
}

var a = TextStyle();

class MyApp extends StatelessWidget {
  const MyApp({super.key});



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: DefaultTextStyle(
          style: TextStyle(color: Colors.black, fontSize: 20),
          child: Text('Instagram'),
        ),
        centerTitle: false,
        actions: [Icon(Icons.add_box_outlined)],
      ),
      body: (Text("안녕", style: a,)),
    );
  }
}

