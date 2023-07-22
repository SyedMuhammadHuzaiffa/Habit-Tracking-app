import 'dart:async';

import 'package:flutter/material.dart';
import 'package:habit_tracker/main.dart';

class Splash extends StatefulWidget {
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => MyHomePage(title: "Habit Tracker")));
    });
  }

  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        color: Colors.green,
        child: Center(
          child: Text("Splash Screen"),
        ),
      ),
    );
  }
}
