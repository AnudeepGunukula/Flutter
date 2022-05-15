import 'package:flutter/material.dart';
import 'package:myapp/answer.dart';
import 'package:myapp/question.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;

  final Function answerQuestion;

  final int questionIndex;

  Quiz(
      {required this.questions,
      required this.answerQuestion,
      required this.questionIndex});

  @override
  Widget build(BuildContext context) {
    return Column(
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        Question(questions[questionIndex]['questionText'].toString()),
        ...(questions[questionIndex]['answers'] as List<Map<String, Object>>)
            .map((answer) {
          return Answer(
              answer['text'].toString(), () => answerQuestion(answer['score']));
        }).toList()
      ],
    );
  }
}
