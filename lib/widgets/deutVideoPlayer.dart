import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../model/chewieListItem.dart';
import '../model/filters.dart';

class DeutVideoPlayer extends StatefulWidget {
  final index;

  const DeutVideoPlayer({Key key, @required this.index}) : super(key: key);
  @override
  _DeutVideoPlayerState createState() => _DeutVideoPlayerState();
}

class _DeutVideoPlayerState extends State<DeutVideoPlayer> {
  var videos = [
    "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
    "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
    "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4",
    "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Видео',
          style: TextStyle(fontSize: 20, color: const Color(0xffFFFFFF)),
        ),
        backgroundColor: const Color(0xff4644FF), // status bar color
        brightness: Brightness.light,
      ),
      body: ColorFiltered(
          child: ChewieListItem(
            videoPlayerController:
                VideoPlayerController.network(videos[widget.index as int]),
            looping: true,
          ),
          colorFilter: ColorFilter.matrix(DEUT_MATRIX)),
    );
  }
}
