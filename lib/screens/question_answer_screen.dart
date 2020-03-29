import 'dart:async';
import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:circular_countdown/circular_countdown.dart';
import 'package:flutter/material.dart';
import 'package:kanyana/components/reusable_card.dart';
import 'package:kanyana/components/rounded_button.dart';
import 'package:kanyana/constants.dart';
import 'package:kanyana/database_collection/mark_db.dart';
import 'package:kanyana/models/mark_model.dart';
import 'package:kanyana/models/question_model.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class QuestionAnswerScreen extends StatefulWidget {
  final String title;

  QuestionAnswerScreen({this.title});

  @override
  _QuestionAnswerScreenState createState() => _QuestionAnswerScreenState();
}

class _QuestionAnswerScreenState extends State<QuestionAnswerScreen> {
  int questionCount = 0;
  int oncePerQuestion = 0;
  Color aAnswer = kNormal;
  Color bAnswer = kNormal;
  Color cAnswer = kNormal;
  IconData nextIcon = Icons.arrow_forward_ios;
  List<QuestionModel> questionModels = [];
  bool isAnySync=true;
  String question =
      '-';
  //bool isImage = false;
  int score = 0;
  final int totalSeconds = 30;
  int seconds=30;
  Timer timer;

  @override
  void initState() {
    updateUI();
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      if (--seconds == 0) {
        timer.cancel();
        setState(() {
          checkForCorrectButton();
          oncePerQuestion=1;
        });
        //ToDo: Timer Out
      }
      setState(() {

      });
    });
    print(questionModels.length);

    super.initState();

  }

  void updateUI() async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("assets/question1.json");
    final jsonResult = await json.decode(data);
    //print(jsonResult);

      if (jsonResult == null) {
        return;
      }
      for (int i = 1; i <= 50; i++) {
        questionModels.add(QuestionModel(
          questionName: jsonResult['$i']['question'],
          answer: jsonResult['$i']['ans'],
          a: jsonResult['$i']['a'],
          b: jsonResult['$i']['b'],
          c: jsonResult['$i']['c'],
        ));
      }
    setState(() {
      isAnySync=false;
    });

  }

  @override
  void dispose() {
    print('Dispose');
    timer.cancel();
    super.dispose();
  }

  void correctAnswer() {
    score++;
  }

  void answerButtonClick() {
    if (questionModels.length -1 == questionCount) nextIcon = Icons.storage;
    oncePerQuestion = 1;
    timer.cancel();

  }

  void checkForCorrectButton() {
    switch (questionModels[questionCount].answer) {
      case 'a':
        aAnswer = kCorrect;
        break;
      case 'b':
        bAnswer = kCorrect;
        break;
      case 'c':
        cAnswer = kCorrect;
        break;
    }
  }

  Widget questionType() {
    if (questionCount+1<=40) {
      return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: AutoSizeText(
            questionModels.length > 0
                ? questionModels[questionCount].questionName
                : question,
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 15),
            maxLines: 4,
          ));
    } else {
      //ToDo : For Image Question
      return Image(
        image: AssetImage('images/q1/${questionCount+1}.jpg'),
        height: 100,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text(widget.title),
        leading: Center(
          child: IconButton(
            icon: Icon(
              Icons.home,
              color: Colors.white,
              size: 40,
            ),
            onPressed: (){
              Navigator.pop(context);
              //ToDo: Home Button Click
            },
          ),
        ),
        actions: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${questionCount + 1}/50',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
      body: ModalProgressHUD(
        inAsyncCall: isAnySync,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'လက်ရှိရမှတ် : $score',
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                            ),
                            CircularCountdown(
                              diameter: 50,
                              countdownTotal: totalSeconds,
                              countdownRemaining: seconds,
                              countdownCurrentColor: Colors.lightBlueAccent,
                              strokeWidth: 10.0,
                              textSpan: TextSpan(text: '$seconds'),
                            ),
                          ],
                        ),
                        Text(
                          'မေးခွန်း -',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        ReusableCard(
                          cardChild: questionType(),
                          color: Colors.deepPurple[700],
                        ),
                        Text(
                          'အဖြေရွေးပါ -',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        ReusableCard(
                          cardChild: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                RoundedButtonAns(
                                  text: questionModels.length > 0
                                      ? questionModels[questionCount].a
                                      : question,
                                  color: aAnswer,
                                  onPressed: () {

                                    if (oncePerQuestion == 1) return;
                                    setState(() {
                                      answerButtonClick();
                                      if (questionModels[questionCount].answer == 'a') {
                                        correctAnswer();
                                        aAnswer = kCorrect;
                                      } else {
                                        aAnswer = kWrong;
                                        checkForCorrectButton();
                                      }
                                    });
                                  },
                                ),
                                RoundedButtonAns(
                                  text: questionModels.length > 0
                                      ? questionModels[questionCount].b
                                      : question,
                                  color: bAnswer,
                                  onPressed: () {
                                    if (oncePerQuestion == 1) return;
                                    setState(() {
                                      answerButtonClick();
                                      if (questionModels[questionCount].answer == 'b') {
                                        print('you hit me');
                                        // audioPlayer.play('assets/correct_sound.mp',isLocal: true);
                                        correctAnswer();
                                        bAnswer = kCorrect;
                                      } else {
                                        bAnswer = kWrong;
                                        checkForCorrectButton();
                                      }
                                    });
                                  },
                                ),
                                RoundedButtonAns(
                                  text: questionModels.length > 0
                                      ? questionModels[questionCount].c
                                      : question,
                                  color: cAnswer,
                                  onPressed: () {
                                    if (oncePerQuestion == 1) return;
                                    setState(() {
                                      answerButtonClick();
                                      if (questionModels[questionCount].answer == 'c') {
                                        correctAnswer();
                                        cAnswer = kCorrect;

                                      } else {
                                        cAnswer = kWrong;
                                        checkForCorrectButton();
                                      }
                                    });
                                  },
                                )
                              ],
                            ),
                          ),
                          color: Colors.black26,
                        ),
                        SizedBox(height: 2.0,),
                        ReusableCard(
                          color: Colors.deepPurple[900],
                          cardChild:
                          IconButton(
                            onPressed: (){
                              if (questionModels.length-1 > questionCount) {
                                timer.cancel();
                                setState(() {

                                  questionCount++;
                                  aAnswer = kNormal;
                                  bAnswer = kNormal;
                                  cAnswer = kNormal;
                                  oncePerQuestion = 0;
                                  seconds = totalSeconds;
                                  timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
                                    if (--seconds == 0) {
                                      timer.cancel();
                                      setState(() {
                                        checkForCorrectButton();
                                        oncePerQuestion=1;
                                      });
                                      //ToDo: Timer Out
                                    }
                                    setState(() {});
                                  });
                                });
                              }
                              else{
                                MarkDatabase().updateMark(Marks(questionSet: widget.title,mark: score));
                                Navigator.pop(context);
                              }

                            },
                            iconSize: 30,
                            icon: Icon(
                              nextIcon,
                              color: Colors.yellow,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                ],
              ),
            ),
//          SingleChildScrollView(
//            child:
//          ),
            Container(
              color: Colors.white,
              height: 60,
            )
          ],
        ),
      ),
    );
  }
}
