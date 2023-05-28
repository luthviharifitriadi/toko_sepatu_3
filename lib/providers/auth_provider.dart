import 'package:flutter/material.dart';
import 'package:toko_sepatu_3/models/user_model.dart';
import 'package:toko_sepatu_3/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  UserModel _user;

  UserModel get user => _user;

  set user(UserModel user) {
    _user = user;
    notifyListeners();
  }

  Future<bool> register({
    String name,
    String username,
    String email,
    String password,
    String phone,
  }) async {
    try {
      UserModel user = await AuthService().register(
        name: name,
        username: username,
        email: email,
        password: password,
        phone: phone,
      );
      _user = user;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> login({
    String email,
    String password,
  }) async {
    try {
      UserModel user = await AuthService().login(
        email: email,
        password: password,
      );

      _user = user;

      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString("token", user.token);

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> getUser({
    String token,
  }) async {
    try {
      UserModel user = await AuthService().getUser(token);

      _user = user;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> profile({
    String token,
    String name,
    String username,
    String email,
  }) async {
    try {
      if (await AuthService().profile(token, name, username, email)) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}
