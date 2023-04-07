import 'package:aplikasi_cookus/screens/dashboard.dart';
import 'package:aplikasi_cookus/service/serviceAuth.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:aplikasi_cookus/constants.dart';
import 'package:aplikasi_cookus/screens/register_view.dart';

class LoginPage extends StatelessWidget {
  static const routeName = "/loginPage";

  TextEditingController UsernameController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: 6000,
            height: 5000,
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
              Padding(
                padding: const EdgeInsets.only(top: 120, left: 24, right: 24),
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(height: 170),
                      Column(
                        children: [
                          TextFormField(
                            controller: UsernameController,
                            decoration: InputDecoration(
                                fillColor: Color(0xffF1F0F5),
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                labelText: 'Username',
                                labelStyle: TextStyle(
                                    color: Color.fromRGBO(249, 135, 135, 1))),
                          ),
                          SizedBox(height: 30),
                          TextFormField(
                            controller: PasswordController,
                            obscureText: true,
                            decoration: InputDecoration(
                                fillColor: Color(0xffF1F0F5),
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                labelText: 'Password',
                                labelStyle: TextStyle(
                                    color: Color.fromRGBO(249, 135, 135, 1))),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                  top: 474,
                  left: 21,
                  child: Container(
                      width: 347,
                      height: 54,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        color: Color.fromRGBO(255, 255, 255, 1),
                      ))),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 488, left: 160),
                    child: Column(
                      /// Add this
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        TextButton(
                          child: Text(
                            'Masuk',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Color.fromRGBO(255, 136, 136, 1),
                                fontFamily: 'Inter',
                                fontSize: 15,
                                letterSpacing:
                                    0 /*percentages not used in flutter. defaulting to zero*/,
                                fontWeight: FontWeight.normal,
                                height: 1),
                          ),
                          onPressed: () async {
                            final message = await AuthService().login(
                                username: UsernameController.text,
                                password: PasswordController.text
                            );
                            if(message!.contains('Success')){
                              Navigator.pushNamed(context, Dashboard.routeName);
                            }
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(message)),
                            );
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Positioned(
                  top: 170,
                  left: 24,
                  child: Container(
                      child: Column(
                    children: <Widget>[
                      Text(
                        'Selamat Datang di',
                        style: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            fontFamily: 'Inter',
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            height: 1),
                      ),
                    ],
                  ))),
              Positioned(
                  top: 190,
                  left: 24,
                  child: Container(
                      child: Column(
                    children: <Widget>[
                      Text(
                        'Cookus',
                        style: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            fontFamily: 'Inter',
                            fontSize: 45,
                            fontWeight: FontWeight.normal,
                            height: 1),
                      ),
                    ],
                  ))),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 534, left: 90),
                    child: Column(
                      /// Add this
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        TextButton(
                          child: Text(
                            'Belum punya akun ? Daftar Sekarang',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 1),
                                fontFamily: 'Inter',
                                fontSize: 12,
                                letterSpacing:
                                    0 /*percentages not used in flutter. defaulting to zero*/,
                                fontWeight: FontWeight.normal,
                                height: 1),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(
                                context, RegisterPage.routeName);
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Positioned(
                  top: 26,
                  left: 295,
                  child: Container(
                      width: 73,
                      height: 27,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('images/logo.png'),
                            fit: BoxFit.fitWidth),
                      )))
            ])));
  }
}
