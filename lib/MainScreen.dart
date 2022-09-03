import 'package:final_project/Home.dart';
import 'package:final_project/LogIn.dart';
import 'package:final_project/UserModel.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  User? user = null;

  @override
  Widget build(BuildContext context) {
    if(user == null)
      return LogIn(logIn: logIn,);
    else
    return Home(logOut: logOut,user: user,);
  }

  void logIn(User? currentUser){
    setState(() =>
    user = currentUser);
  }

  void logOut(){
    setState(() =>
    user = null);
  }
}
