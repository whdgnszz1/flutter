import 'package:flutter/material.dart';

void main() {
  runApp( MyApp());
}


class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var a = 1;
  var name = ['김영숙','홍길동', '피자집'];

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        home: Scaffold(
          appBar: AppBar( title: Text("연락처 앱"), centerTitle: false,),
          body: ListView.builder(
            itemCount: 3,
            itemBuilder: (context, i){
              print(i);
              return UserList(name: name[i]);
              },
          ) ,
          bottomNavigationBar: Footer(),
        )
    );

  }
}

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(Icons.phone),
          Icon(Icons.message),
          Icon(Icons.contact_page)
        ],
      ),
    );
  }
}



class UserList extends StatefulWidget {
  final String name;
  UserList({required this.name, Key? key}) : super(key: key);

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  var a = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(a.toString()),
              Text(widget.name),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                a++;
              });
            },
            child: Text('좋아요'),
          ),
        ],
      ),
    );
  }
}


