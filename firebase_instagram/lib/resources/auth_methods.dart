import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_instagram/models/user.dart' as model;
import 'package:firebase_instagram/resources/storage_methods.dart';
import 'package:flutter/material.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // sign up user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = 'Some error occured';
    try{
      if(email.isNotEmpty || password.isNotEmpty || username.isNotEmpty ||bio.isNotEmpty
          || file != null
      ) {
        // register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);

        print(cred.user!.uid);
        
        String photoUrl = await StorageMethods().uploadImageToStorage('profilePics', file, false);
        
        // add user to our database
        
        model.User user = model.User(
            username: username,
            uid: cred.user!.uid,
            email: email,
            bio: bio,
            followers: [],
            following: [],
            photoUrl: photoUrl
        );

        await _firestore.collection('users').doc(cred.user!.uid).set(user.toJson(),);

        //
        // await _firestore.collection('users').add({
        //   'username': username,
        //   'uid': cred.user!.uid,
        //   "email": email,
        //   "bio": bio,
        //   "followers": [],
        //   "following": [],
        // });

        res = "success";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // login user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error occured";

    try {
      if(email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(email: email, password: password);
        res = 'success';
      } else {
        res = '이메일 또는 비밀번호를 입력해주세요';
      }
    } catch (err) {
        res = err.toString();
    }
    return res;
  }
}