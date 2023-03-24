import 'package:aplikasi_cookus/screens/home_view.dart';
import 'package:flutter/material.dart';
import 'package:aplikasi_cookus/screens/login_view.dart';
import 'dart:async';

class SplashScreenPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    startSplashScreen();
  }

  startSplashScreen() async {
    var duration = const Duration(seconds: 5);
    return Timer(duration, () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) {
          return HomePage();
        }),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator SplashscreenWidget - FRAME
    return Container(
        width: 390,
        height: 844,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(),
          gradient: LinearGradient(
              begin: Alignment(-0.30106812715530396, 0.7442885041236877),
              end: Alignment(-0.7442885041236877, -1.4100043773651123),
              colors: [
                Color.fromRGBO(249, 135, 135, 1),
                Color.fromRGBO(255, 255, 255, 1)
              ]),
        ),
        child: Stack(children: <Widget>[
          Positioned(
              top: 250,
              left: 46,
              child: Container(
                  width: 297,
                  height: 95,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/logo.png'),
                        fit: BoxFit.fitWidth),
                  ))),
        ]));
  }
}
