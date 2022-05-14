// ignore_for_file: prefer_const_constructors, unused_local_variable, avoid_print, must_be_immutable

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  var questionIndex = 0;

  void answerQuestion() {
    setState(() {
      questionIndex += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    var questions = [
      'What\'s your favourite color? ',
      'what\'s your favourite animal? ',
    ];
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('MyQuizApp')),
        ),
        body: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Text(questions[questionIndex]),
            ElevatedButton(
              onPressed: () {
                /*

              
                */
                answerQuestion();
                print('Answer 1 chosen');
              },
              child: Text('Answer 1'),
            ),
            ElevatedButton(
              onPressed: () => print('Answer 2 chosen'),
              child: Text('Answer 2'),
            ),
            ElevatedButton(
              onPressed: () => print('Answer 3 chosen'),
              child: Text('Answer 3'),
            ),
          ],
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
