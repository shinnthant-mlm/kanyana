import 'package:flutter/material.dart';
import 'package:kanyana/components/rounded_button.dart';
import 'package:kanyana/screens/question_answer_screen.dart';
import 'package:kanyana/screens/scroe_screen.dart';

class QuestionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              RoundedButtonBig(
                color: Colors.deepPurpleAccent,
                text: 'Question Set 1',
                onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(
                          builder: (context)=>QuestionAnswerScreen(title:'Question Set 1')
                      )
                  );
                },

              ),
              RoundedButtonBig(
                color: Colors.deepPurpleAccent,
                text: 'Question Set 2',
                onPressed: (){

                },

              ),
              RoundedButtonBig(
                color: Colors.deepPurpleAccent,
                text: 'Question Set 3',
                onPressed: (){
                },

              ),
              RoundedButtonBig(
                color: Colors.deepPurpleAccent,
                text: 'Question Set 4',
                onPressed: (){
                },

              ),
              RoundedButtonBig(
                color: Colors.deepPurpleAccent,
                text: 'Question Set 5',
                onPressed: (){
                },

              ),
              RoundedButton(
                color: Colors.deepPurpleAccent,
                text: 'Score',
                onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>ScoreScreen()));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
