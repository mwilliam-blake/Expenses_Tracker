import 'dart:async';
import 'package:expense_app/UI/screens/expenses.dart';
import 'package:expense_app/data/local/db/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../home.dart';

void main() {
  runApp(splash_screen());
}

class splash_screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Ecco Build",
      debugShowCheckedModeBanner: false,
      home: splashScreen(),
    );
  }
}

class splashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _splashstate();
}

Future<bool> check_sharedPreferences() async {
  SharedPreferences sprefer = await SharedPreferences.getInstance();
  if(sprefer.containsKey('user_id')) {
    return true;
  } else {
    return false;
  }
}

class _splashstate extends State<splashScreen> {
  @override

  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5),() async{
      SharedPreferences sprefer = await SharedPreferences.getInstance();

      if(sprefer.containsKey('user_id')) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => ExpensePage()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MyHomePages()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        "lib/domain/app/assets/images/splash.jpg",
        fit: BoxFit.fitWidth,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
      ),
    );
  }
}

