import 'package:aplikasi_cookus/menu/dashboard_view.dart';
import 'package:aplikasi_cookus/menu/create_view.dart';
import 'package:aplikasi_cookus/menu/profile_view.dart';
import 'package:flutter/material.dart';

class LayoutNavigationBar extends StatefulWidget {
  @override
  _LayoutNavigationBarState createState() => _LayoutNavigationBarState();
}

class _LayoutNavigationBarState extends State<LayoutNavigationBar> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    MenuCookus(),
    Create(),
    Profile(),
  ];
  void onBarTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color.fromRGBO(249, 135, 135, 1),
        currentIndex: _currentIndex,
        onTap: onBarTapped,
        items: [
          BottomNavigationBarItem(icon: new Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: new Icon(Icons.create), label: 'Create'),
              
          BottomNavigationBarItem(
              icon: new Icon(Icons.person), label: 'Account'),
        ],
      ),
    ));
  }
}
