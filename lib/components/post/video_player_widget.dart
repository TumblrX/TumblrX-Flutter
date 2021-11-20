import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String _url;
  final String _provider;
  VideoPlayerWidget(this._url, this._provider);
  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  VideoPlayerController _videoController;
  // YoutubePlayerController _youtubeController;
  @override
  void initState() {
    if (widget._provider == 'youtube') {
      // RegExp regExp = new RegExp(
      //     r'^.*((youtu.be\/)|(v\/)|(\/u\/\w\/)|(embed\/)|(watch\?))\??v?=?([^#&?]*).*');
      // final RegExpMatch match = regExp.firstMatch(widget._url);
      // String videoId = match != null ? match.group(0) : null;
      // if (videoId != null)
      //   _youtubeController = YoutubePlayerController(initialVideoId: videoId);
    }
    _videoController = VideoPlayerController.network(widget._url)
      ..initialize().then((value) => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _videoController.dispose();
  }

  dynamic _buildVideoPlayer() {
    // if (widget._provider == 'youtube')
    //   return YoutubePlayer(
    //     controller: _youtubeController,
    //     showVideoProgressIndicator: true,
    //   );
    if (widget._provider == 'vimeo') return;
    return _videoController.value.isInitialized
        ? AspectRatio(
            aspectRatio: _videoController.value.aspectRatio,
            child: VideoPlayer(_videoController),
          )
        : Container();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: _buildVideoPlayer(),
      ),
    );
  }
}
