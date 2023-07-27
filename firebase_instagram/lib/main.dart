import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_instagram/providers/user_provider.dart';
import 'package:firebase_instagram/responsive/mobile_screen_layout.dart';
import 'package:firebase_instagram/responsive/responsive_layout_screen.dart';
import 'package:firebase_instagram/responsive/web_screen_layout.dart';
import 'package:firebase_instagram/screens/login_screen.dart';
import 'package:firebase_instagram/screens/signup_screen.dart';
import 'package:firebase_instagram/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Instagram Clone',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            // 로그인 상태가 확정되었을 때
            if (snapshot.connectionState == ConnectionState.active) {
              // 로그인한 사용자가 있을 때
              if (snapshot.hasData) {
                return const ResponsiveLayout(
                  mobileScreenLayout: MobileScreenLayout(),
                  webScreenLayout: WebScreenLayout(),
                );
              }
              // 로그인한 사용자가 없을 때
              return const LoginScreen();
            }

            // 에러가 발생했을 때
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'An error occurred: ${snapshot.error}',
                  style: TextStyle(color: Colors.red),
                ),
              );
            }

            // 로그인 상태를 확인 중일 때
            return Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            );
          },
        ),
      ),
    );
  }
}
