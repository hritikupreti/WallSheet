import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class ChewieItems extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final bool looping;
  // ignore: use_key_in_widget_constructors
  const ChewieItems(
      {required this.looping, required this.videoPlayerController});

  @override
  _ChewieItemsState createState() => _ChewieItemsState();
}

class _ChewieItemsState extends State<ChewieItems> {
  ChewieController? _chewieController;
  @override
  void initState() {
    super.initState();
    _chewieController = ChewieController(
      videoPlayerController: widget.videoPlayerController,
      aspectRatio: 6 / 4,
      autoInitialize: true,
      looping: widget.looping,
      showControlsOnInitialize: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Chewie(controller: _chewieController!);
  }

  @override
  void dispose() {
    super.dispose();
    widget.videoPlayerController.dispose();
    _chewieController!.dispose();
  }
}
