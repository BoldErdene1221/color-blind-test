import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../model/chewieListItem.dart';
import '../model/filters.dart';

class ProtVideoPlayer extends StatefulWidget {
  final index;

  const ProtVideoPlayer({Key key, @required this.index}) : super(key: key);

  @override
  _ProtVideoPlayerState createState() => _ProtVideoPlayerState();
}

class _ProtVideoPlayerState extends State<ProtVideoPlayer> {
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
        body: Container(
          child: ColorFiltered(
              child: ChewieListItem(
                videoPlayerController:
                    VideoPlayerController.network(videos[widget.index as int]),
                looping: true,
              ),
              colorFilter: ColorFilter.matrix(PROT_MATRIX)),
        ));
  }
}
