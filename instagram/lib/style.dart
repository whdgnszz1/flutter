import 'package:flutter/material.dart';

var theme = ThemeData(
  // textButtonTheme: TextButtonThemeData(
  //   style: TextButton.styleFrom(
  //     backgroundColor: Colors.grey,
  //   )
  // ),
  iconTheme: IconThemeData(color: Colors.black), // 아이콘의 기본 색상을 지정
  appBarTheme: AppBarTheme(
    color: Colors.white,
    elevation: 1,
    titleTextStyle: TextStyle(color: Colors.black, fontSize: 25),
    actionsIconTheme: IconThemeData(color: Colors.black),
  ),
  textTheme: TextTheme(
    bodyText2: TextStyle(color: Colors.black), // 기본 텍스트 스타일을 지정
  ),
);