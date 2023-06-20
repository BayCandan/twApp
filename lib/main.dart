import 'package:flutter/material.dart';
import 'package:twapp/pages/auth/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:twapp/pages/auth/sign_up.dart';
import 'package:twapp/pages/home_page.dart';
import 'package:twapp/utils/customColors.dart';
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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/loginPage": (context) => LoginPage(),
        "/signUp": (context) => SignUp(),
        "/homePage": (context) => HomePage(),
      },
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo', //02223350580 3914
      theme: ThemeData(
          scaffoldBackgroundColor: CustomColors.scaffoldBackgroundColor),
      home: const LoginPage(),
    );
  }
}
