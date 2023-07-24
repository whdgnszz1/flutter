import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final auth = FirebaseAuth.instance;
final firestore = FirebaseFirestore.instance;



class Shop extends StatefulWidget {
  const Shop({super.key});

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {

  getData() async {
    // try {
    //   var result = await auth.signInWithEmailAndPassword(
    //     email: "kim@test.com",
    //     password: "123456",
    //   );
    //   result.user?.updateDisplayName("종훈");
    //   print(result.user);
    // } catch (e) {
    //   print(e);
    // }
    await auth.signOut();

    if(auth.currentUser?.uid == null){
      print('로그인 안된 상태군요');
    } else {
      print('로그인 하셨네');
    }
    await firestore.collection('product').get();
  }


  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('샵페이지임!!'),
    );
  }
}
