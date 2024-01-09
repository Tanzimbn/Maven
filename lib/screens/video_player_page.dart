import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/enrolledController.dart';
import 'package:flutter_application_1/screens/course_detail.dart';
import 'package:flutter_application_1/theme/color.dart';
import 'package:flutter_application_1/widgets/basic_overlay_widget.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'video.dart';

class VideoPlayerPage extends StatefulWidget {
  final data;
  // final videos;
  // final int currentIndex;
  final Function(bool) onVideoComplete;
  final complete;

  VideoPlayerPage({
    required this.data,
    // required this.currentIndex,
    required this.onVideoComplete,
    required this.complete,
  });
  
  get width => 100;

  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late VideoPlayerController _controller;
  // late int currentIndex;
  late ValueNotifier<double> _progressNotifier;
  bool videocompleteSeen = false;
  bool already_seen = false;
  bool isloading = false;

  @override
  void initState() {
    super.initState();
    // currentIndex = widget.currentIndex;
    already_seen = widget.complete;
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.data['video']["url"]))
      ..initialize().then((_) {
        setState(() {});
      });
    _progressNotifier = ValueNotifier<double>(0.0);
    _controller.addListener(() {
      if (_controller.value.position == _controller.value.duration &&
          !_controller.value.isPlaying && widget.complete == false) {
        videocompleteSeen = true;
      }
    });
    // _controller.addListener(() {
    //   final progress = _controller.value.position.inMilliseconds /
    //       _controller.value.duration! .inMilliseconds;
    //   _progressNotifier.value = progress;

    //   if (progress >= 1) {
    //     widget.onVideoComplete(true);
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.data['video']["title"]),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              // _goToNextVideo();
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Text(
          //   'Video ${currentIndex + 1} / ${widget.videos.length}',
          //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          // ),
          // SizedBox(height: 20),
          Container(
            width: double.infinity,
            height: 200, // Adjust the height as needed
            child: _controller.value.isInitialized
                ? buildVideo()
                : CircularProgressIndicator(),
          ),
          SizedBox(height: 20),
          already_seen ?
          SizedBox()
          : isloading ?
          Center(
              child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(AppColor.primary),
              ),
          )
          : ElevatedButton(
            onPressed: () async {
              setState(() {
                isloading = true;
              });
              if(videocompleteSeen) {
                widget.onVideoComplete(true);
                await Get.find<enrolledController>().updateResource(FirebaseAuth.instance.currentUser!.uid, widget.data['course']['id'], true);
                setState(() {
                  videocompleteSeen = true;
                  already_seen = true;
                });
                Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) =>
                            CourseDetailPage(data: {"course": widget.data['course']})),
                      );  
              }
              else {
                await _showMessage(context, "You haven't seen full video.", true, "Sorry!");
              }
              setState(() {
                isloading = false;
              });
            }, 
            child: Text('Marked as completed'),
          ),
          // ElevatedButton(
          //   onPressed: () {
          //     _goToNextVideo();
          //   },
          //   child: Text('Next Video'),
          // ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              _controller.play();
            }
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }

  Future<void> _showMessage(BuildContext context, String mess, bool _error, String title) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColor.textColor,
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          content: Text(mess),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Ok'),
              style: ElevatedButton.styleFrom(
                backgroundColor: _error ? AppColor.red : AppColor.green,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget buildVideo() => Stack(
    alignment: Alignment.center,
    children: <Widget>[
      buildVideoPlayer(),
      overlay(),
    ],
  );

  Widget buildVideoPlayer() => AspectRatio(
    aspectRatio: _controller.value.aspectRatio,
    child: VideoPlayer(_controller),
  ); 

  Widget overlay() => GestureDetector(
    behavior: HitTestBehavior.opaque,
        onTap: () {
          setState(() {
            _controller.value.isPlaying ? _controller.pause() : _controller.play();
          });
        },
        child: Stack(
          children: <Widget>[
            buildPlay(),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: buildIndicator(),
            ),
          ],
        ),
  );

  Widget buildIndicator() => VideoProgressIndicator(
        _controller,
        allowScrubbing: true,
      );

  Widget buildPlay() => _controller.value.isPlaying
      ? Container()
      : Container(
          alignment: Alignment.center,
          color: Colors.black26,
          child: Icon(Icons.play_arrow, color: Colors.white, size: 80),
        );

  // void _goToNextVideo() {
  //   if (currentIndex < widget.videos.length - 1) {
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => VideoPlayerPage(
  //           videos: widget.videos,
  //           currentIndex: currentIndex + 1,
  //           onVideoComplete: (isComplete) {
  //             widget.onVideoComplete(isComplete);
  //           },
  //         ),
  //       ),
  //     );
  //   } else {
  //     Navigator.pop(context);
  //   }
  // }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}