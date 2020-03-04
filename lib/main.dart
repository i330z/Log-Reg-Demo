import 'package:flutter/material.dart';
import 'package:logindemo/screens/login.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: LoginScreen()
    );
  }
}