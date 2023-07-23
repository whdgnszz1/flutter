import 'package:flutter/material.dart';
import './style.dart' as style;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:provider/provider.dart';


void main() {
  runApp(ChangeNotifierProvider(
    create: (c) => Store1(),
    child: MaterialApp(
        theme: style.theme,
      home: const MyApp()
    ),
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
  var userImage;

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
              onPressed: () async {
                var picker = ImagePicker();
                var image = await picker.pickImage(source: ImageSource.gallery);
                if(image != null) {
                  setState(() {
                    userImage = File(image.path);
                  });
                }
                print(userImage);
                Navigator.push(context,
                    MaterialPageRoute(builder: (c) => Upload( userImage: userImage, addList: addList )));
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
                (widget.list[i]["image"] is File)
                    ? Image.file(widget.list[i]["image"])
                    : Image.network(widget.list[i]["image"]),
                Container(
                  constraints: BoxConstraints(maxWidth: 600),
                  padding: EdgeInsets.all(20),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        child: Text(widget.list[i]["user"]),
                        onTap: (){
                          Navigator.push(context,
                            // MaterialPageRoute(builder: (c) => Text('위젯')
                            PageRouteBuilder(
                                pageBuilder: (context, a1, a2) => Profile(),
                                transitionsBuilder: (context, a1, a2 ,child) =>
                                    SlideTransition(
                                        position: Tween(
                                          begin: Offset(-1.0, 0.0),
                                          end: Offset(0.0, 0.0),
                                        ).animate(a1),
                                    child: child,)
                                  // FadeTransition(opacity: a1, child: child,),
                                // transitionDuration: Duration(milliseconds: 500)
                                )
                          );
                        },
                      ),
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
  Upload({Key? key, this.userImage, this.addList}) : super(key:key);
  final userImage;
  final addList;
  var inputData = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [ TextButton(onPressed: (){
          var newList = {
            'id': 4,
            'image': userImage,
            'likes': 10,
            'date': '7월 22일',
            'content': inputData.text,
            'user': '종훈'
          };
          addList(newList);
          Navigator.pop(context);
        }, child: Text("등록하기")) ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.file(userImage),
          Text('이미지 업로드 화면'),
          TextField(controller: inputData,),
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

class Store1 extends ChangeNotifier {
  var name = 'john kim';
  var follower = 0;
  changeName(){
    name = 'john park';
    notifyListeners();
  }

}



// Profile
class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.watch<Store1>().name) ,),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset('assets/placeholder.png',width: 40),
            Text('팔로워 ${context.watch<Store1>().follower}명'),
            ElevatedButton(onPressed: (){
              context.read<Store1>().changeName();
            }, child: Text('버튼'))
          ],
        ),
      ),
    );
  }
}
