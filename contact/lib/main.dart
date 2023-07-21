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
              actions: [Icon(Icons.search),Icon(Icons.dehaze), Icon(Icons.notifications)],
              leading: Text("금호동3가"),
            ),
            body:Container( // 부모 위젯 (Container 등 다른 위젯을 사용해도 됨)
              width: double.infinity, // Container의 너비를 원하는 값으로 설정 (예시로 300 지정)
              color: Colors.white, // Container 배경색 (테스트를 위해 색상 지정)
              height: 200,
              child: Row(
                mainAxisSize: MainAxisSize.max, // Row가 부모의 가로 영역을 전부 차지하도록 설정
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('/placeholder.png'),
                        fit: BoxFit.cover
                      )
                    ),
                  ),
                  Container(
                    width: 450,
                    height: 200,
                    color: Colors.white,
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 100,
                          child: Text("캐논 DSLR 100D (단렌즈, 충전기 16기가 SD 포함"),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 30,
                          child: Text("성동구 행당동 끌올 10분 전"),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 30,
                          child: Text("210,000원"),
                        ),
                        Container(
                          width: double.infinity,
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 30,
                                height: 30,
                                child: Icon(Icons.heart_broken),
                              ),
                              SizedBox(
                                width: 30,
                                height: 30,
                                child: Center(child: Text("4", textAlign: TextAlign.center)),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
            ,
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
