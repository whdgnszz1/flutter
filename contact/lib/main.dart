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
            body: Text('안녕'),
            bottomNavigationBar: BottomAppBar(
              child: Container(
                height: 80, // 원하는 높이로 설정
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
