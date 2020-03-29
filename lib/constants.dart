import 'package:flutter/material.dart';
final kTextFieldUsernameDecoration=InputDecoration(

    border:OutlineInputBorder(
    gapPadding: 2,
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    hintText: 'username',
    filled: true,
    hintStyle: TextStyle(color: Colors.deepPurple[400],fontSize: 18),
    fillColor: Colors.deepPurple[700]
);
final kTextFieldPasswordDecoration=InputDecoration(

    hintText: 'password',
    border:OutlineInputBorder(
      gapPadding: 2.0,
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
    ),
    filled: true,
    hintStyle:TextStyle(color: Colors.deepPurple[400],fontSize: 18),
    fillColor: Colors.deepPurple[700],

);

const kCorrect=Colors.green;
const kWrong=Colors.red;
final kNormal=Colors.deepPurple[700];