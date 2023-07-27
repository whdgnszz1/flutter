import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_instagram/screens/add_post_screen.dart';
import 'package:firebase_instagram/screens/feed_screen.dart';
import 'package:firebase_instagram/screens/login_screen.dart';
import 'package:firebase_instagram/screens/profile_screen.dart';
import 'package:firebase_instagram/screens/seearch_screen.dart';
import 'package:firebase_instagram/screens/signup_screen.dart';
import 'package:flutter/material.dart';

const webScreenSize = 600;

List<Widget> get homeScreenItems {
  final currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser == null) {
    // 로그인/회원가입 화면을 반환하도록 수정
    return [SignupScreen(), LoginScreen()];
  }

  return [
    FeedScreen(),
    SearchScreen(),
    AddPostScreen(),
    Text('notif'),
    ProfileScreen(uid: currentUser.uid,),
  ];
}
