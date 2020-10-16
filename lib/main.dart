import 'package:flutter/material.dart';
import 'package:sistema_ochoa/src/pages/home_page.dart';
import 'package:sistema_ochoa/src/pages/login_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      
      initialRoute: 'login',
      routes: {
        'login': (BuildContext context) => LoginPage(),
        'home' : (BuildContext context) => Home(),
      },
    );
  }
}