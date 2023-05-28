import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toko_sepatu_3/providers/auth_provider.dart';
import 'package:toko_sepatu_3/providers/category_provider.dart';
import 'package:toko_sepatu_3/providers/products_provider.dart';
import 'package:toko_sepatu_3/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

Future<String> getToken() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString("token") ?? "";
}

class _SplashPageState extends State<SplashPage> {
  bool tes = false;
  String token = "";

  @override
  void initState() {
    // TODO: implement initState

    getInit();
    super.initState();
  }

  getInit() async {
    await Provider.of<ProductProvider>(context, listen: false).getProducts();
    await Provider.of<CategoryProvider>(context, listen: false).getCategories();
    getToken().then((String ret) {
      if (ret != "") {
        Provider.of<AuthProvider>(context, listen: false).getUser(token: ret);
      }
    });
    if (await getToken() != "") {
      await Future.delayed(Duration(seconds: 5));
      Navigator.pushNamed(context, '/home');
    } else {
      Navigator.pushNamed(context, '/sign-in');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor1,
      body: Center(
        child: Container(
          width: 130,
          height: 150,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/Image_Splash.png'),
            ),
          ),
        ),
      ),
    );
  }
}
