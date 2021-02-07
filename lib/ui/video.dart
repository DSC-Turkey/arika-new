import 'package:arika/config/admob/admob.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Video extends StatefulWidget {
  final url;

  Video({this.url});

  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<Video> {
  ChewieController chewieController;
  VideoPlayerController videoPlayerController;
  bool looping;

  @override
  void initState() {
    super.initState();

    AdMobService.getNewTripInterstitial()
      ..load()
      ..show();
    chewieController = ChewieController(
      videoPlayerController: VideoPlayerController.network(widget.url),
      aspectRatio: 16 / 9,
      autoInitialize: true,
      looping: true,
      autoPlay: true,
    );
    //_controller = VideoPlayerController.asset("videos/sample_video.mp4");
  }

  @override
  void dispose() {
    chewieController?.dispose();
    videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("url ${widget.url}");
    return Scaffold(
      body: Chewie(
        controller: chewieController,
      ),
    );
  }
}
