import 'package:flutter/material.dart';
import './style.dart' as style;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/rendering.dart';

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
  var list = [];

  getData() async {
    try {
      var result = await http.get(Uri.parse('https://codingapple1.github.io/app/data.json'));
      print( jsonDecode(result.body) );
      setState(() {
        list = jsonDecode(result.body);
      });
    } catch (error) {
      print("Error fetching data: $error");
    }
  }

  addList(moreList){
    setState(() {
      list.add(moreList);
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  // 전체 레이아웃
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
              onPressed: (){
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Upload() )
                );
              },
              icon: Icon(Icons.add_box_outlined),
              iconSize: 30,
          )
          ],
      ),
      body: [ Home(list: list, addList: addList), Text("샵페이지")][tab],
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


// 메인페이지
class Home extends StatefulWidget {
  Home({Key? key, this.list, this.addList}) : super(key: key);
  final list;
  final addList;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var scroll = ScrollController();

  getData() async {
    try {
      return await http.get(Uri.parse('https://codingapple1.github.io/app/more1.json'));
    } catch (error) {
      print("Error fetching data: $error");
    }
  }

  @override
  void initState() {
    super.initState();
    scroll.addListener(() async {
      if(scroll.position.pixels == scroll.position.maxScrollExtent){
        print("같음");
        var data = await getData();
        if (data != null) {
          print(jsonDecode(data.body));
          widget.addList(jsonDecode(data.body));
          print(widget.list);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.list.isNotEmpty){
      return ListView.builder(
          itemCount: widget.list.length,
          controller: scroll,
          itemBuilder: (c, i){
            return Column(
              children: [
                Image.network(widget.list[i]["image"]),
                Container(
                  constraints: BoxConstraints(maxWidth: 600),
                  padding: EdgeInsets.all(20),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('좋아요 ${widget.list[i]["likes"]}'),
                      Text(widget.list[i]["date"]),
                      Text(widget.list[i]["content"]),
                    ],
                  ),
            )
          ],
        );
      });
    } else {
      return Text("로딩중임");
    }
  }
}

// 이미지 업로드 페이지
class Upload extends StatelessWidget {
  const Upload({Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('이미지 업로드 화면'),
          IconButton(
              onPressed: (){
                Navigator.pop(context);
              }, 
              icon: Icon(Icons.close))
        ],
      ),
    );
  }
}

