import 'package:cloud_firestore/cloud_firestore.dart';
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

                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(photoUrl),
                    ),
                    title: Text(username),
                  );
                }
            );
          },
        ) : FutureBuilder(
          future: FirebaseFirestore.instance.collection('posts').get(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: const CircularProgressIndicator(),
              );
            }

            if(snapshot.hasError) {
              return Center(child: Text('오류가 발생했습니다.'));
            }

            final documents = (snapshot.data! as dynamic).docs;
            return StaggeredGridView.countBuilder(
              crossAxisCount: 3,
              itemCount: documents.length,
              itemBuilder: (context, index) {
                final doc = documents[index];
                final postUrl = doc.get('postUrl') ?? 'default_post_image_url';

                return Image.network(postUrl);
              },
              staggeredTileBuilder: (index) => StaggeredTile.count(
                  (index % 7 == 0) ? 2 : 1,
                  (index % 7 == 0) ? 2 : 1),
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            );
          },
        )


    );
  }
}
