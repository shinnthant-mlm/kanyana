
import 'package:flutter/material.dart';
import 'package:kanyana/components/score_card.dart';
import 'package:kanyana/database_collection/mark_db.dart';
import 'package:kanyana/models/mark_model.dart';
class ScoreScreen extends StatefulWidget {

  @override
  _ScoreScreenState createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {

  List<Widget> scoreCardList=[];
  void initState(){
  updateUI();
    // TODO: implement initState
    super.initState();
  }

  void updateUI()async{
    List<Map<String,dynamic>> mapList=await MarkDatabase().getData();
    print(mapList.length);
    for(int i =0;i<mapList.length;i++) {
      int mark=Marks().fromMap(mapList[i]).mark;
      scoreCardList.add(ScoreCard(text:'Question Set ${i+1} :  $mark'));
    }
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar:AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text('My Score',style: TextStyle(fontSize: 30),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children:scoreCardList,
        ),
      )
    );
  }
}
