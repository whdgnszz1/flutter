import 'package:flutter/material.dart';
import './style.dart' as style;

void main() {
  runApp(MaterialApp(
      theme: style.theme,
    home: const MyApp()
  ));
}

var a = TextStyle();

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var tab = 0;



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: DefaultTextStyle(
          style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
          child: Text('Instagram'),
        ),
        centerTitle: false,
        actions: [
          IconButton(
              onPressed: (){},
              icon: Icon(Icons.add_box_outlined)
          )
          ],
      ),
      body: [
        ListView.builder(
          itemCount: 3,
          itemBuilder: (context,i) {
            return MainCard();
          }),
        Text("샵페이지")]
      [tab],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (i){
          setState(() {
            tab = i;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "홈"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined), label: "샵"),
        ],
      ),
    );
  }
}



class MainCard extends StatelessWidget {
  const MainCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset('placeholder.png', fit: BoxFit.cover, width:double.infinity,),
          Text('좋아요 100', style: TextStyle(fontWeight: FontWeight.w600),),
          Text('글쓴이'),
          Text('글내용'),
        ],
      ),
    );
  }
}

