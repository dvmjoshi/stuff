import "package:flutter/material.dart";
import 'package:stuff/Loginpage.dart';
import 'package:stuff/explore.dart';
import 'package:stuff/home.dart';
import 'package:stuff/signup.dart';
void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new MyHomePage(),

    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Firebase Auth",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home:LoginPage(),
      routes: <String,WidgetBuilder>{
        "/Homepage":(BuildContext context)=>new home(),
        "/loginpage":(BuildContext context)=>new LoginPage(),
        "/signup":(BuildContext context)=>new SignUpPage(),
        "/carry":(BuildContext context)=>new ExploreStuff(flipScreenCtrl: null,)
      },
    );
  }
}
