import 'package:flutter/material.dart';
import 'package:toko_sepatu_3/pages/sign_in_page.dart';
import 'package:toko_sepatu_3/pages/splash_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => SplashPage(),
        '/sign-in': (context) => SignInPage(),
      },
    );
  }
}
