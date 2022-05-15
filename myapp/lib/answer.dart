import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final String answerText;

  final VoidCallback answerQuestion;

  Answer(this.answerText, this.answerQuestion);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: answerQuestion,
        child: Text(answerText),
        style: ElevatedButton.styleFrom(
          primary: Colors.pink,
        ),
      ),
    );
  }
}
