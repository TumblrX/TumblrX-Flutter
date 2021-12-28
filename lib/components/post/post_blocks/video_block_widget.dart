import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tumblrx/global.dart';
import 'package:video_player/video_player.dart';
//import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
//import 'package:vimeo_player_flutter/vimeo_player_flutter.dart';

class VideoBlockWidget extends StatefulWidget {
  final String _provider;
  final String _url;
  VideoBlockWidget({Key key, String url, String provider})
      : _url = url,
        _provider = provider,
        super(key: key);

  @override
  State<VideoBlockWidget> createState() => _VideoBlockWidgetState();
}

class _VideoBlockWidgetState extends State<VideoBlockWidget> {
  VideoPlayerController _videoController;
  YoutubePlayerController _youtubeController;
  @override
  void initState() {
    if (widget._provider == 'youtube') {
      RegExp regExp = RegExp(
          r"^.*(youtu\.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*");
      RegExpMatch match = regExp.firstMatch(widget._url);
      String videoId;
      if (match != null) videoId = match.group(2);
      if (videoId != null) {
        _youtubeController = YoutubePlayerController(
            initialVideoId: videoId,
            params: YoutubePlayerParams(autoPlay: false, mute: true));
      } else
        logger.i('video id is $videoId');
    } else if (widget._provider != 'vimeo') {
      _videoController = VideoPlayerController.network(widget._url)
        ..initialize().then((value) => setState(() {}));
    }

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    if (_videoController != null) _videoController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: _buildVideoPlayer(),
      ),
    );
  }

  dynamic _buildVideoPlayer() {
    if (widget._provider == 'youtube')
      return Row(
        children: [
          Expanded(
            child: YoutubePlayerIFrame(
              controller: _youtubeController,
            ),
          ),
        ],
      );
    // if (widget._provider == 'vimeo') {
    //   String videoId = widget._url.split('/').last;
    //   logger.i('video id is $videoId');
    //   return Container(
    //     height: 250,
    //     child: Center(
    //       child: VimeoPlayer(
    //         videoId: videoId,
    //       ),
    //     ),
    //   );
    // }
    return _videoController.value.isInitialized
        ? AspectRatio(
            aspectRatio: _videoController.value.aspectRatio,
            child: VideoPlayer(_videoController),
          )
        : Container();
  }
}
