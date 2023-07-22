import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';

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

  getPermission() async {
    var status = await Permission.contacts.status;
    if (status.isGranted) {
      print('허락됨');
      var contacts = await ContactsService.getContacts();
      // print(contacts[0].familyName);
      var newPerson = Contact();
      newPerson.givenName= "민수";
      newPerson.familyName= "김";
      ContactsService.addContact(newPerson);
      
    } else if (status.isDenied) {
      print('거절됨');
      Permission.contacts.request();
    }
  }

  var total = 3;
  var a = 1;
  var name = ['김영숙','홍길동', '피자집'];

  addOne(){
    setState(() {
      total++;
    });
  }

  addFriend(newFriend){
    setState(() {
      name.add(newFriend);
    });
  }


  @override
  Widget build(BuildContext context) {

    return  Scaffold(
          floatingActionButton: FloatingActionButton(
              onPressed: (){
                showDialog(context: context, builder: (context){

                  return DialogUI(addOne: addOne, addFriend: addFriend);
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
          appBar: AppBar( title: Text(total.toString()), centerTitle: false, actions: [
            IconButton(onPressed: (){ getPermission(); }, icon: Icon(Icons.contacts))
          ],),
          body: ListView.builder(
            itemCount: name.length,
            itemBuilder: (context, i){
              return ListTile(
                leading: Image.asset('assets/placeholder.png'),
                title: Text(name[i]),
              );
              },
          ) ,
          bottomNavigationBar: Footer(),
        );
  }
}

// Dialog
class DialogUI extends StatefulWidget {
  DialogUI({Key? key, this.addOne, this.addFriend}) : super(key: key);
  final addOne;
  final addFriend;

  @override
  State<DialogUI> createState() => _DialogUIState();
}

class _DialogUIState extends State<DialogUI> {
  var inputData = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: 300,
        height: 300,
        child: Column(
          children: [
            TextField( controller: inputData,),
            TextButton(onPressed: () {
              widget.addOne();
              widget.addFriend(inputData.text);
              Navigator.pop(context);
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


