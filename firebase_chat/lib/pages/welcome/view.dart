import 'package:firebase_chat/pages/welcome/controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class WelcomePage extends GetView<WelcomeController> {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: Text('First page'),
      ),
    );
  }
}