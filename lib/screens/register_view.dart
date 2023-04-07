import 'package:aplikasi_cookus/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:aplikasi_cookus/constants.dart';
import 'package:aplikasi_cookus/screens/login_view.dart';

import '../service/serviceAuth.dart';
import 'dashboard.dart';

class RegisterPage extends StatefulWidget {
  static const routeName = "/RegisterPage";

  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  var NamaLengkapController = TextEditingController();
  var UsernameController = TextEditingController();
  var EmailController = TextEditingController();
  var PasswordController = TextEditingController();
  var PasswordConfirmController = TextEditingController();

  bool isSubmit = false;

  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator LoginWidget - FRAME
    return Scaffold(
        body: Container(
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
              Padding(
                padding: const EdgeInsets.only(top: 200, left: 24, right: 24),
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(height: 1),
                      Column(
                        children: [
                          TextFormField(
                            controller: NamaLengkapController,
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
                                labelText: 'Nama Lengkap',
                                labelStyle: TextStyle(
                                    color: Color.fromRGBO(249, 135, 135, 1))),
                          ),
                          SizedBox(height: 20),
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
                          SizedBox(height: 20),
                          TextFormField(
                            controller: EmailController,
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
                                labelText: 'Email',
                                labelStyle: TextStyle(
                                    color: Color.fromRGBO(249, 135, 135, 1))),
                          ),
                          SizedBox(height: 20),
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
                          SizedBox(height: 20),
                          TextFormField(
                            onChanged: (String value) async {
                              if(value == PasswordController.text){
                                setState(() {
                                  isSubmit = true;
                                });
                              }
                            },
                            controller: PasswordConfirmController,
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
                                labelText: 'Confirm Password',
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
                  top: 590,
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
                    padding: const EdgeInsets.only(top: 600, left: 160),
                    child: Column(
                      /// Add this
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        TextButton(
                          child: Text(
                            'Daftar',
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
                            if(isSubmit == true){
                              final message = await AuthService().registration(
                                  username: UsernameController.text,
                                  password: PasswordController.text,
                                  nama_lengkap: NamaLengkapController.text,
                                  email: EmailController.text
                              );
                              if (message!.contains('Success')) {
                                Navigator.pushNamed(context, Dashboard.routeName);
                              }
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(message)),
                              );
                            }else{
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Password Confirm harus sama")),
                              );
                              setState(() {
                                PasswordConfirmController.text = "";
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Positioned(
                  top: 120,
                  left: 27,
                  child: Container(
                      child: Column(
                    children: <Widget>[
                      Text(
                        'Daftar',
                        style: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            fontFamily: 'Inter',
                            fontSize: 45,
                            fontWeight: FontWeight.normal,
                            height: 1),
                      ),
                    ],
                  ))),
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
