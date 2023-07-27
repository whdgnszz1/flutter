import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_instagram/screens/profile_screen.dart';
import 'package:firebase_instagram/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  bool isShowUsers = false;

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: TextFormField(
          decoration: const InputDecoration(
            labelText: 'Search for user'
          ),
          onFieldSubmitted: (String _) {
            setState(() {
              isShowUsers = true;
            });
          },
        ),
      ),
        body: isShowUsers? FutureBuilder(
          future: FirebaseFirestore.instance.collection('users')
              .where('username', isEqualTo: searchController.text)
              .get(),
          builder: (context, snapshot){
            if(snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if(snapshot.hasError) {
              return Center(child: Text('오류가 발생했습니다.'));
            }

            final documents = (snapshot.data! as dynamic).docs;
            return ListView.builder(
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  final doc = documents[index];
                  final photoUrl = doc.get('photoUrl') ?? 'default_image_url';
                  final username = doc.get('username') ?? '알 수 없음';

                  return InkWell(
                    onTap: () => Navigator
                        .of(context)
                        .push(
                        MaterialPageRoute(builder: (context) =>
                        ProfileScreen(
                            uid: (snapshot.data! as dynamic).docs[index]['uid'])
                        ),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(photoUrl),
                      ),
                      title: Text(username),
                    ),
                  );
                }
            );
          },
        ) : FutureBuilder(
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

            return MasonryGridView.count(
              crossAxisCount: 3,
              itemCount: (snapshot.data! as dynamic).docs.length,
              itemBuilder: (context, index) => Image.network(
                (snapshot.data! as dynamic).docs[index]['postUrl'],
                fit: BoxFit.cover,
              ),
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
            );
          },
        ),


    );
  }
}
