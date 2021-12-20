import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/services/creating_post.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';

///The preview of the added video to post create where it keeps repeating.
class VideoPlayerPreview extends StatefulWidget {
  ///The video data to be shown.
  final XFile file;

  final String url;
  VideoPlayerPreview({this.file, this.url});
  @override
  _VideoPlayerPreviewState createState() => _VideoPlayerPreviewState();
}

class _VideoPlayerPreviewState extends State<VideoPlayerPreview> {
  VideoPlayerController _controller;
  VideoPlayerController _toBeDisposed;

  @override
  void initState() {
    super.initState();
    widget.url == null
        ? _playVideo(file: widget.file)
        : _playVideo(url: widget.url);
  }

  @override
  void deactivate() {
    if (_controller != null) {
      _controller.setVolume(0.0);
      _controller.pause();
    }
    super.deactivate();
  }

  @override
  void dispose() {
    _disposeVideoController();
    // maxWidthController.dispose();
    // maxHeightController.dispose();
    // qualityController.dispose();
    super.dispose();
  }

  Future<void> _disposeVideoController() async {
    if (_toBeDisposed != null) {
      await _toBeDisposed.dispose();
    }
    _toBeDisposed = _controller;
    _controller = null;
  }

  Future<void> _playVideo({XFile file, String url}) async {
    if (url == null &&
        file == null &&
        !kIsWeb &&
        defaultTargetPlatform == TargetPlatform.android) {
      file = await Provider.of<CreatingPost>(context, listen: false)
          .retrieveLostData();
    }
    if (mounted) {
      await _disposeVideoController();
      VideoPlayerController controller;
      if (url == null) {
        if (kIsWeb) {
          controller = VideoPlayerController.network(file.path);
        } else {
          controller = VideoPlayerController.file(File(file.path));
        }
      } else {
        controller = VideoPlayerController.network(url);
      }

      _controller = controller;
      // In web, most browsers won't honor a programmatic call to .play
      // if the video has a sound track (and is not muted).
      // Mute the video so it auto-plays in web!
      // This is not needed if the call to .play is the result of user
      // interaction (clicking on a "play" button, for example).
      final double volume = kIsWeb ? 0.0 : 1.0;
      await controller.setVolume(volume);
      await controller.initialize();
      await controller.setLooping(true);
      await controller.play();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_controller != null) {
      return AspectRatioVideo(_controller);
    } else {
      return SizedBox.shrink();
    }
  }
}

class AspectRatioVideo extends StatefulWidget {
  AspectRatioVideo(this.controller);

  final VideoPlayerController controller;

  @override
  AspectRatioVideoState createState() => AspectRatioVideoState();
}

class AspectRatioVideoState extends State<AspectRatioVideo> {
  VideoPlayerController get controller => widget.controller;
  bool initialized = false;

  void _onVideoControllerUpdate() {
    if (!mounted) {
      return;
    }
    if (initialized != controller.value.isInitialized) {
      initialized = controller.value.isInitialized;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(_onVideoControllerUpdate);
  }

  @override
  void dispose() {
    controller.removeListener(_onVideoControllerUpdate);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (initialized) {
      return Center(
        child: AspectRatio(
          aspectRatio: controller.value.aspectRatio,
          child: VideoPlayer(controller),
        ),
      );
    } else {
      return Container();
    }
  }
}
