// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gminor/Widgets/songimg.dart';
import 'package:just_audio/just_audio.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final player = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();

    player.playerStateStream.listen((event) {
      if (event.playing) {
        setState(() {
          isPlaying = true;
        });
      } else {
        setState(() {
          isPlaying = false;
        });
      }
    });

    player.durationStream.listen((event) {
      duration = Duration(seconds: event!.inSeconds);
    });

    player.positionStream.listen((event) {
      setState(() {
        position = Duration(seconds: event.inSeconds);
      });
    });

    startSongs();
  }

  void startSongs() async {
    await player.setUrl(
        'https://aac.saavncdn.com/191/0c353932c6bb495fe0e6e885c42a7367_320.mp4');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 89, 88, 86),
      height: double.infinity,
      width: double.infinity,
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        const SizedBox(
          height: 50,
        ),
        SongImg(),
        SizedBox(
          height: 50,
        ),
        Text('Kesariya'),
        SizedBox(
          height: 50,
        ),
        Slider(
          activeColor: Colors.yellow,
          inactiveColor: Colors.black,
          min: 0.0,
          max: duration.inSeconds.toDouble(),
          value: position.inSeconds.toDouble(),
          // max: 10,
          // value: _value,
          onChanged: (value) async {
            final position = Duration(seconds: value.toInt());
            await player.seek(position);
          },
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(position.toString().substring(2, 7)),
              Text((duration - position).toString().substring(2, 7)),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () => {},
                icon: Icon(
                  size: 50.0,
                  Icons.skip_previous_sharp,
                ),
              ),
              IconButton(
                onPressed: () async {
                  if (isPlaying) {
                    await player.pause();
                  } else {
                    await player.play();
                  }
                },
                icon: isPlaying
                    ? Icon(
                        size: 50,
                        Icons.pause_circle_filled_outlined,
                      )
                    : Icon(
                        size: 50,
                        Icons.play_circle_fill_outlined,
                      ),
              ),
              IconButton(
                  onPressed: () => {},
                  icon: Icon(
                    size: 50,
                    Icons.skip_next_sharp,
                  )),
            ],
          ),
        ),
      ]),
    );
  }
}
