import 'package:flutter/material.dart';
import 'package:kanyana/components/rounded_button.dart';
import 'package:kanyana/constants.dart';
import 'package:kanyana/screens/question_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(left: 0,top: 200,right: 0,bottom: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Image(
                image: AssetImage('images/logo.jpg'),
                height: 100,
              ),
              Container(
                height: 350,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextField(
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(fontSize: 18),
                          decoration: kTextFieldUsernameDecoration),
                      SizedBox(
                        height: 5,
                      ),
                      TextField(
                          obscureText: true,
                          style: TextStyle(fontSize: 18),
                          decoration: kTextFieldPasswordDecoration),
                      RoundedButton(
                        color: Colors.deepPurple[300],
                        text: 'Login',
                        onPressed: (){
                          //ToDo: Login Code Here
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>QuestionScreen()));
                        },
                      ),


                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
