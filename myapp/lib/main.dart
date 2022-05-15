// ignore_for_file: prefer_const_constructors, unused_local_variable, avoid_print, must_be_immutable

import 'package:flutter/material.dart';
import 'package:myapp/quiz.dart';
import 'package:myapp/result.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  var _questionIndex = 0;
  var _totalScore = 0;
  final questions = const [
    {
      'questionText': 'what\'s your favourite color ?',
      'answers': [
        {'text': 'Black', 'score': 10},
        {'text': 'Red', 'score': 5},
        {'text': 'Green', 'score': 3},
        {'text': 'White', 'score': 1}
      ]
    },
    {
      'questionText': 'what\'s your favourite animal ?',
      'answers': [
        {'text': 'Rabbit', 'score': 3},
        {'text': 'Snake', 'score': 10},
        {'text': 'Elephant', 'score': 5},
        {'text': 'Lion', 'score': 9}
      ]
    },
    {
      'questionText': 'who\'s your favourite Instructor ?',
      'answers': [
        {'text': 'Max', 'score': 1},
        {'text': 'Stephen', 'score': 1},
        {'text': 'Jonas', 'score': 1},
        {'text': 'Ravi', 'score': 1},
      ]
    }
  ];

  void _resetQuiz() {
    _totalScore = 0;
    setState(() {
      _questionIndex = 0;
    });
  }

  void _answerQuestion(int score) {
    _totalScore += score;
    setState(() {
      _questionIndex = _questionIndex + 1;
    });

    if (_questionIndex < questions.length) {
      print('we have more questions');
    } else {
      print('No more questions');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('MyQuizApp')),
          backgroundColor: Colors.pink,
        ),
        body: _questionIndex < questions.length
            ? Quiz(
                questions: questions,
                answerQuestion: _answerQuestion,
                questionIndex: _questionIndex,
              )
            : Result(_totalScore, _resetQuiz),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
