import 'package:flutter/material.dart';
import 'package:tumblrx/components/post/post_blocks/audio_block_widget.dart';
import 'package:tumblrx/components/post/post_blocks/image_block_widget.dart';
import 'package:tumblrx/components/post/post_blocks/link_block_widget.dart';
import 'package:tumblrx/components/post/post_blocks/text_block_widget.dart';
import 'package:tumblrx/components/post/post_blocks/video_block_widget.dart';
import 'package:tumblrx/components/post/post_footer/post_footer.dart';
import 'package:tumblrx/components/post/post_header.dart';
import 'package:tumblrx/components/post/tags_widget.dart';
import 'package:tumblrx/models/post.dart';
import 'package:tumblrx/models/posts/audio_block.dart';
import 'package:tumblrx/models/posts/image_block.dart';
import 'package:tumblrx/models/posts/link_block.dart';
import 'package:tumblrx/models/posts/text_block.dart';
import 'package:tumblrx/models/posts/video_block.dart';

class PostWidget extends StatelessWidget {
  final List _postContent;
  final List<String> _tags;
  final List<Post> _trail;
  final int _index;
  PostWidget(
      {Key key,
      @required List postContent,
      @required int index,
      List tags,
      List trail})
      : _postContent = postContent,
        _index = index,
        _tags = tags == null ? [] : tags,
        _trail = trail == null ? [] : trail,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    //final int len = post.trail.length;
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PostHeader(index: _index),
          Divider(),
          /*
          len > 0? 
          
          for(int i = 1; i < len; i++){

          }
          post.trail.map((rebloged){
            

          }).toList(),: Container(width:0, height:0),
          ,
          */
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _postContent.map<Widget>(
              (block) {
                switch (block.runtimeType) {
                  case TextBlock:
                    return TextBlockWidget(text: block.formattedText);
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
                    return VideoBlockWidget();
                    break;
                  case AudioBlock:
                    return AudioBlockWidget();
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
          Divider(
            color: Colors.transparent,
          ),
          PostFooter(postIndex: _index),
        ],
      ),
    );
  }
}
