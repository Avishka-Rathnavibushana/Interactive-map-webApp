import 'package:flutter/material.dart';
import 'package:interactive_map/main_buildings/home.dart';
import 'package:video_player/video_player.dart';

class BankVideo extends StatefulWidget {
  BankVideo({Key? key}) : super(key: key);
  @override
  _BankVideoState createState() => _BankVideoState();
}

class _BankVideoState extends State<BankVideo> {
  late VideoPlayerController _controller;

  int index = 0;
  bool show = false;
  final String url = 'assets/videos/bank_REV_v001.mp4';

  setIndex(value) {
    index = value;
    setState(() {});
  }

  setShow() {
    setState(() {
      show = !show;
    });
  }

  @override
  void initState() {
    index = 0;
    show = false;
    _controller = VideoPlayerController.asset(url)
      ..initialize().then((_) => {
            setState(() {
              _controller.setVolume(0);
              _controller.setLooping(false);
            })
          });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    bool _isPlaying = false;
    int index = 0;

    setIndex(value) {
      index = value;
      setState(() {});
    }

    return Scaffold(
      // Use a FutureBuilder to display a loading spinner while waiting for the
      // VideoPlayerController to finish initializing.
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              // Use the VideoPlayer widget to display the video.
              child: VideoPlayer(_controller),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _controller.play();

          _controller.addListener(() {
            final bool isPlaying = _controller.value.isPlaying;

            if (isPlaying != _isPlaying) {
              setState(() {
                _isPlaying = isPlaying;
                setIndex(++index);
              });
              if (index > 1) {
                _controller.removeListener(() {});
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        const HomeVideo(),
                    transitionDuration: const Duration(seconds: 2),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) =>
                            FadeTransition(
                      opacity: animation,
                      child: child,
                    ),
                  ),
                );
              }
            }
          });
        },
        // Display the correct icon depending on the state of the player.
        child: const Icon(
          Icons.arrow_back,
        ),
      ),
    );
  }
}