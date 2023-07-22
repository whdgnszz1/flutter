import 'package:flutter/material.dart';
import './style.dart' as style;

void main() {
  runApp(MaterialApp(
      theme: style.theme,
    home: const MyApp()
  ));
}

var a = TextStyle();

class MyApp extends StatelessWidget {
  const MyApp({super.key});



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
      body: Text('안녕', style: Theme.of(context).textTheme.bodyText2,),
      bottomNavigationBar: BottomAppBar(
        height: 70,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(onPressed: (){}, icon: Icon(Icons.home_outlined)),
              IconButton(onPressed: (){}, icon: Icon(Icons.shopping_bag_outlined))
            ],
          ),
        ),
    );
  }
}

