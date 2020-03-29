import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
class ScoreCard extends StatelessWidget {
  final text;
  ScoreCard({this.text});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 9.0,
      color: Colors.deepPurple[900],
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical:30.0),
        child: AutoSizeText(text,textAlign: TextAlign.center,
          maxLines: 1,
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}
