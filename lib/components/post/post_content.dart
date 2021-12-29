import 'package:flutter/material.dart';
import 'package:tumblrx/components/post/post_blocks/audio_block_widget.dart';
import 'package:tumblrx/components/post/post_blocks/image_block_widget.dart';
import 'package:tumblrx/components/post/post_blocks/link_block_widget.dart';
import 'package:tumblrx/components/post/post_blocks/text_block_widget.dart';
import 'package:tumblrx/components/post/post_blocks/video_block_widget.dart';
import 'package:tumblrx/components/post/tags_widget.dart';
import 'package:tumblrx/models/posts/audio_block.dart';
import 'package:tumblrx/models/posts/image_block.dart';
import 'package:tumblrx/models/posts/link_block.dart';
import 'package:tumblrx/models/posts/text_block.dart';
import 'package:tumblrx/models/posts/video_block.dart';

class PostContentView extends StatelessWidget {
  final List _postContent;
  final List _tags;
  const PostContentView({Key key, List postContent, List tags})
      : _postContent = postContent,
        _tags = tags,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _postContent.map<Widget>(
            (block) {
              switch (block.runtimeType) {
                case TextBlock:
                  return TextBlockWidget(
                    text: block.formattedText,
                    sharableText: block.text,
                  );
                  break;
                case LinkBlock:
                  return LinkBlockWidget(
                      url: block.url, description: block.description);
                  break;
                case ImageBlock:
                  return ImageBlockWidget(
                    media: block,
                  );
                  break;
                case VideoBlock:
                  return VideoBlockWidget(
                      url: block.url, provider: block.provider);
                  break;
                case AudioBlock:
                  return AudioBlockWidget(
                    url: block.url,
                    provider: block.provider,
                  );
                  break;
                default:
                  return Container(width: 0, height: 0);
              }
            },
          ).toList(),
        ),
        Divider(
          color: Colors.transparent,
        ),
        TagsWidget(_tags),
      ],
    );
  }
}
