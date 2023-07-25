import 'dart:typed_data';

import 'package:firebase_instagram/models/user.dart';
import 'package:firebase_instagram/providers/user_provider.dart';
import 'package:firebase_instagram/resources/firestore_methods.dart';
import 'package:firebase_instagram/utils/colors.dart';
import 'package:firebase_instagram/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _file;
  final TextEditingController _descriptionController = TextEditingController();

  void postImage(
      String uid,
      String username,
      String profImage,
      ) async {

    try {
      String res = await FirestoreMethods().uploadPost(
          _descriptionController.text,
          _file!,
          uid,
          username,
          profImage,
      );
        if(res == 'success'){
          showSnackBar("게시글 작성 완료!", context);
        } else {
          showSnackBar(res, context);
        }
      } catch(err) {
        showSnackBar(err.toString(), context);
      }
    }


  _selectImage(BuildContext context) async {
    return showDialog(context: context, builder: (context) {
      return SimpleDialog(
        title: const Text('게시글 작성'),
        children: [
          SimpleDialogOption(
            padding: const EdgeInsets.all(20),
            child: const Text('카메라 사진'),
            onPressed: () async {
              Navigator.of(context).pop();
              Uint8List? file = await pickImage(
                  ImageSource.camera
              );
              setState(() {
                _file = file;
              });
            },
          ),
          SimpleDialogOption(
            padding: const EdgeInsets.all(20),
            child: const Text('갤러리에서 사진 선택'),
            onPressed: () async {
              Navigator.of(context).pop();
              Uint8List? file = await pickImage(
                  ImageSource.gallery
              );
              setState(() {
                _file = file;
              });
            },
          ),
          SimpleDialogOption(
            padding: const EdgeInsets.all(20),
            child: const Text('취소'),
            onPressed: ()  {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    });
  }


  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;

    return _file == null
        ? Center(
            child: IconButton(
              icon: const Icon(Icons.upload),
              onPressed: () => _selectImage(context),
            ),
          )
    : Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: (){},
        ),
        title: const Text('Post to'),
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: () => postImage(user.uid, user.username, user.photoUrl),
            child: const Text("Post", style: TextStyle(
            color: Colors.blueAccent,
            fontWeight: FontWeight.bold,
            fontSize: 16
          ),
          ),
          )
        ],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(user.photoUrl),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.45,
                child: TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    hintText: '내용을 적어주세요.',
                    border: InputBorder.none,
                  ),
                  maxLines: 8,
                ),
              ),
              SizedBox(
                height: 45,
                width: 45,
                child: AspectRatio(
                  aspectRatio: 487/451,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: MemoryImage(_file!),
                        fit: BoxFit.fill,
                        alignment: FractionalOffset.topCenter,
                      )
                    ),
                  ),
                ),
              ),
              const Divider(),
            ],
          )
        ],
      ),
    );
  }
}
