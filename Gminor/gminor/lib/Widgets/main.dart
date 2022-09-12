import 'package:flutter/material.dart';
import 'homepage.dart';

void main() {
  runApp(const Gminor());
}

class Gminor extends StatelessWidget {
  const Gminor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text('Gminor'),
        ),
        body: HomePage(),
      ),
    );
  }
}
