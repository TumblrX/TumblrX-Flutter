import 'package:flutter/material.dart';
import 'package:tumblrx/components/post/post_blocks/media_preview_widget.dart';
import 'package:tumblrx/models/posts/image_block.dart';

class ImageBlockWidget extends StatelessWidget {
  final ImageBlock _media;
  const ImageBlockWidget({Key key, ImageBlock media})
      : _media = media,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return _media != null
        ? MediaWidget(_media.url, _media.width, _media.height)
        : Container(
            child: Center(
              child: Icon(Icons.error),
            ),
          );
  }
}
