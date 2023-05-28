import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toko_sepatu_3/pages/cart_page.dart';
import 'package:toko_sepatu_3/pages/checkout_page.dart';
import 'package:toko_sepatu_3/pages/checkout_success_page.dart';
import 'package:toko_sepatu_3/pages/home/home_page.dart';
import 'package:toko_sepatu_3/pages/home/profile_page.dart';
import 'package:toko_sepatu_3/providers/auth_provider.dart';
import 'package:toko_sepatu_3/providers/cart_provider.dart';
import 'package:toko_sepatu_3/providers/category_provider.dart';
import 'package:toko_sepatu_3/providers/page_provider.dart';
import 'package:toko_sepatu_3/providers/products_provider.dart';
import 'package:toko_sepatu_3/providers/transaction_provider.dart';
import 'package:toko_sepatu_3/providers/wishlist_provider.dart';
import 'package:toko_sepatu_3/services/auth_service.dart';
import 'pages/splash_page.dart';
import 'pages/sign_in_page.dart';
import 'pages/sign_up_page.dart';
import 'pages/home/main_page.dart';
import 'pages/detail_chat_page.dart';
import 'pages/edit_profile_page.dart';
import 'pages/product_page.dart';
import 'pages/cart_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final authProvider = AuthProvider();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => WishlistProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TransactionProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PageProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CategoryProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => SplashPage(),
          '/sign-in': (context) => SignInPage(),
          '/sign-up': (context) => SignUpPage(),
          '/home': (context) => MainPage(),
          //'/detail-chat': (context) => DetaiChatPage(),
          '/edit-profile': (context) => EditProfilePage(),
          '/cart': (context) => ChartPage(),
          '/checkout': (context) => CheckoutPage(),
          '/checkout-success': (context) => CheckoutSuccessPage(),
        },
      ),
    );
  }
}
