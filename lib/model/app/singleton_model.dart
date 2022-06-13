import 'package:flutter/material.dart';
import 'package:leggo/model/user_model.dart';

class SingletonModel {
  static final SingletonModel _singleton = SingletonModel._internal();

  factory SingletonModel(){
    return _singleton;
  }

  SingletonModel._internal();

  static SingletonModel withContext(BuildContext context){
    _singleton.context = context;
    return _singleton;
  }

  static SingletonModel get shared => _singleton;

  late bool isLogin;
  UserModel? user;
  late BuildContext context;
  User? getUser;
}