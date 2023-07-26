import 'package:firebase_instagram/screens/add_post_screen.dart';
import 'package:firebase_instagram/screens/feed_screen.dart';
import 'package:flutter/material.dart';

const webScreenSize = 600;

const homeScreenItems = [
  FeedScreen(),
  Text('search'),
  AddPostScreen(),
  Text('notif'),
  Text('profile'),
];