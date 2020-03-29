import 'package:flutter/material.dart';
import 'package:kanyana/database_collection/mark_db.dart';
import 'package:kanyana/screens/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    try {
      MarkDatabase().createDatabase();
      MarkDatabase().createDefaultMarks();
    }catch(err){
      print('Already Created');
    }
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(primaryColor: Colors.lightBlueAccent),
      home: LoginScreen(),
     // home: QuestionScreen(),
    );
  }
}
