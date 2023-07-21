import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text('앱임', textAlign: TextAlign.left,),
              centerTitle: false,
            ),
            body: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity, height: 50,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  border: Border.all(color: Colors.black)
                ),
              ),
            ),
            bottomNavigationBar: BottomAppBar(
              child: SizedBox(
                height: 70, // 원하는 높이로 설정
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.phone),
                    Icon(Icons.message),
                    Icon(Icons.contact_page)
                  ],
                ),
              ),
            )
        )
    );

  }
}
