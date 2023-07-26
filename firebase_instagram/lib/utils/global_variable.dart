import 'package:firebase_instagram/screens/add_post_screen.dart';
import 'package:firebase_instagram/screens/feed_screen.dart';
import 'package:firebase_instagram/screens/profile_screen.dart';
import 'package:firebase_instagram/screens/seearch_screen.dart';
import 'package:flutter/material.dart';

const webScreenSize = 600;

const homeScreenItems = [
  FeedScreen(),
  SearchScreen(),
  AddPostScreen(),
  Text('notif'),
  ProfileScreen(),
];