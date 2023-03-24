import 'package:flutter/material.dart';
import 'package:aplikasi_cookus/screens/navigation_view.dart';


class Dashboard extends StatelessWidget {
  static const routeName = "/Dashboard";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body:LayoutNavigationBar(),
      ),
    );
  }
}
