import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_instagram/screens/profile_screen.dart';
import 'package:firebase_instagram/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  bool isShowUsers = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: Form(
          child: TextFormField(
            controller: searchController,
            decoration: const InputDecoration(labelText: '유저의 이름을 입력해주세요.'),
            onFieldSubmitted: (String _) {
              setState(() {
                isShowUsers = true;
              });
            },
          ),
        ),
      ),
      body: isShowUsers
          ? FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('users')
            .where(
          'username',
          isGreaterThanOrEqualTo: searchController.text,
        )
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          var documents = (snapshot.data as QuerySnapshot).docs;
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              var docData = documents[index].data() as Map<String, dynamic>;
              return InkWell(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(
                      uid: docData['uid'] ?? 'Unknown UID',
                    ),
                  ),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      docData['photoUrl'] ?? 'https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png',
                    ),
                    radius: 16,
                  ),
                  title: Text(docData['username'] ?? 'Anonymous'),
                ),
              );
            },
          );
        },
      )
          : FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('posts')
            .orderBy('datePublished')
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          var documents = (snapshot.data as QuerySnapshot).docs;
          return MasonryGridView.count(
            crossAxisCount: 3,
            itemCount: documents.length,
            itemBuilder: (context, index) {
              var docData = documents[index].data() as Map<String, dynamic>;
              return Image.network(
                docData['postUrl'] ?? 'https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png',
                fit: BoxFit.cover,
              );
            },
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
          );
        },
      ),
    );
  }
}
