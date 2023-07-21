import 'package:flutter/material.dart';

void main() {
  runApp( MaterialApp(
      home: MyApp()
  ));
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

    return  Scaffold(
          floatingActionButton: FloatingActionButton(
              onPressed: (){
                showDialog(context: context, builder: (context){

                  return DialogUI(state: a, addA: (){
                    setState(() {
                      a++;
                    });
                  });
                  //   Dialog(child:
                  //   Container(
                  //     height: 200,
                  //     child: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Text("Contact", textAlign: TextAlign.left,),
                  //         Padding(
                  //           padding: const EdgeInsets.all(8.0),
                  //           child: TextField(
                  //             // You can customize the text field with various properties
                  //             decoration: InputDecoration(
                  //               labelText: 'Enter your name',
                  //               border: OutlineInputBorder(),
                  //             ),
                  //           ),
                  //         ),
                  //         Row(
                  //           mainAxisAlignment: MainAxisAlignment.end,
                  //           children: [
                  //             TextButton(onPressed: (){
                  //               Navigator.pop(context); // Dialog 닫기
                  //             }, child: Text("Cancel")),
                  //             TextButton(onPressed: (){}, child: Text("OK")),
                  //           ],
                  //         )
                  //       ],
                  //     ),
                  //   )
                  // );
                });
              },
          ),
          appBar: AppBar( title: Text("연락처 앱"), centerTitle: false,),
          body: ListView.builder(
            itemCount: 3,
            itemBuilder: (context, i){
              return ListTile(
                leading: Image.asset('placeholder.png'),
                title: Text(name[i]),
              );
              },
          ) ,
          bottomNavigationBar: Footer(),
        );
  }
}

// Dialog
class DialogUI extends StatelessWidget {
  const DialogUI({Key? key, this.state, this.addA}) : super(key: key);
  final dynamic state;
  final dynamic addA;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: 300,
        height: 300,
        child: Column(
          children: [
            TextField(),
            TextButton(onPressed: () {
              print(state);
              addA?.call();
            }, child: Text("완료")),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("취소"),
            ),
          ],
        ),
      ),
    );
  }
}




// footer
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



// 유저리스트
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


