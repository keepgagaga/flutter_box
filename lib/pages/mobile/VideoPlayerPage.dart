import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerPage extends StatefulWidget {
  final String url;

  const VideoPlayerPage({super.key, required this.url});

  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    SmartDialog.showLoading();
    _controller = VideoPlayerController.network('${widget.url}')
      ..addListener(() {})
      ..initialize().then((_) {
        SmartDialog.dismiss();
        _controller.play();
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _playControl() {
    if (_controller.value.isPlaying) {
      _controller.pause();
    } else {
      _controller.play();
    }
  }

  Widget build(context) {
    Size _size = MediaQuery.of(context).size;

    Widget _playArea = Stack(
      children: [
        GestureDetector(
          onTap: _playControl,
          child: Container(
            alignment: Alignment.center,
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            ),
          ),
        ),
        Container(
          width: _size.width,
          height: _size.height,
          padding: EdgeInsets.only(bottom: 20, top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.arrow_back),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: _size.width * 0.3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.flutter_dash),
                        Text('flutter box'),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: _size.width * 0.5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Icon(Icons.thumb_up_outlined),
                            Text('999'),
                          ],
                        ),
                        Column(
                          children: [
                            Icon(Icons.share_outlined),
                            Text('999'),
                          ],
                        ),
                        Column(
                          children: [
                            Icon(Icons.local_fire_department_outlined),
                            Text('999'),
                          ],
                        ),
                        Column(
                          children: [
                            Icon(Icons.chat_bubble_outline_outlined),
                            Text('999'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );

    return Scaffold(
      body: Center(
        child: _controller.value.isInitialized ? _playArea : Container(),
      ),
    );
  }
}
