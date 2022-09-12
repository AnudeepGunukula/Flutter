import 'package:flutter/material.dart';

class SongImg extends StatelessWidget {
  const SongImg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      width: 320,
      child: Image.network(
        'https://sdlhivkcdnems05.cdnsrv.jio.com/c.saavncdn.com/191/Kesariya-From-Brahmastra-Hindi-2022-20220717092820-500x500.jpg',
        fit: BoxFit.fill,
      ),
    );
  }
}
