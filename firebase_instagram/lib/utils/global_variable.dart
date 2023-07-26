import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_instagram/screens/add_post_screen.dart';
import 'package:firebase_instagram/screens/feed_screen.dart';
import 'package:firebase_instagram/screens/profile_screen.dart';
import 'package:firebase_instagram/screens/seearch_screen.dart';
import 'package:flutter/material.dart';

const webScreenSize = 600;

List<Widget> get homeScreenItems {
  return [
    FeedScreen(),
    SearchScreen(),
    AddPostScreen(),
    Text('notif'),
    ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid,),
  ];
}
