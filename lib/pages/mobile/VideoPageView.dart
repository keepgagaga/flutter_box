import 'package:flutter/material.dart';
import 'package:flutter_box/pages/mobile/VideoPlayerPage.dart';

class VideoPageView extends StatefulWidget {
  _VideoPageViewState createState() => _VideoPageViewState();
}

class _VideoPageViewState extends State<VideoPageView> {
  late PageController _controller;
  int _index = 0;
  List<String> _urls = [
    'http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4',
    'https://www.w3schools.com/html/movie.mp4',
  ];

  @override
  void initState() {
    _controller = PageController(
      initialPage: _index,
      viewportFraction: 1.0,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget build(context) {
    return Scaffold(
      body: PageView(
        scrollDirection: Axis.vertical,
        onPageChanged: (index) {
          _index = index;
        },
        controller: _controller,
        children: _urls.map((u) => VideoPlayerPage(url: u)).toList(),
      ),
    );
  }
}
