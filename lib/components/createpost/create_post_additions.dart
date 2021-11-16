import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/components/createpost/font_style_list.dart';
import 'package:tumblrx/services/post.dart';
import 'add_tags.dart';
import '../modal_bottom_sheet.dart';
import 'link_preview_input.dart';

class CreatePostAdditions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          child: Icon(
            Icons.text_format,
            size: 30.0,
          ),
          onTap: () {
            Provider.of<Post>(context, listen: false).nextTextStyle();
          },
          onLongPress: () {
            Provider.of<Post>(context, listen: false).saveFocusedIndex();
            showDialog(
              context: context,
              builder: (_) => FontStyleList(),
            );
          },
        ),
        SizedBox(
          width: 7.0,
        ),
        InkWell(
          child: Icon(
            Icons.link,
            size: 30.0,
          ),
          onTap: () {
            Provider.of<Post>(context, listen: false).saveFocusedIndex();
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => SingleChildScrollView(
                child: LinkPreviewInput(),
              ),
            );
          },
        ),
        SizedBox(
          width: 7.0,
        ),
        InkWell(
          child: Icon(
            Icons.gif,
            size: 30.0,
          ),
          onTap: () {
            Provider.of<Post>(context, listen: false).addGif(context);
          },
        ),
        SizedBox(
          width: 7.0,
        ),
        InkWell(
          child: Icon(
            Icons.photo_outlined,
            size: 30.0,
          ),
          onTap: () {
            Provider.of<Post>(context, listen: false).saveFocusedIndex();
            showDialog(
                context: context,
                builder: (_) => AlertDialog(
                      scrollable: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                      actions: [
                        InkWell(
                          child: ListTile(
                            leading: Icon(Icons.image),
                            title: Text(!kIsWeb
                                ? 'Pick image from gallery'
                                : 'Upload an Image'),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            Provider.of<Post>(context, listen: false)
                                .addImage(isCamera: false);
                          },
                        ),
                        InkWell(
                          child: ListTile(
                            leading: Icon(Icons.videocam_rounded),
                            title: Text(!kIsWeb
                                ? 'Pick video from gallery'
                                : 'Upload a Video'),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            Provider.of<Post>(context, listen: false)
                                .addVideo(isCamera: false);
                          },
                        ),
                      ],
                    ));
          },
        ),
        SizedBox(
          width: 7.0,
        ),
        !kIsWeb
            ? InkWell(
                child: Icon(
                  Icons.camera_alt_outlined,
                  size: 30.0,
                ),
                onTap: () {
                  Provider.of<Post>(context, listen: false).saveFocusedIndex();
                  showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                            scrollable: true,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                            ),
                            actions: [
                              InkWell(
                                child: ListTile(
                                  leading: Icon(Icons.camera),
                                  title: Text('Take a picture'),
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                  Provider.of<Post>(context, listen: false)
                                      .addImage(isCamera: true);
                                },
                              ),
                              InkWell(
                                child: ListTile(
                                  leading: Icon(Icons.video_call_rounded),
                                  title: Text('Record a video'),
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                  Provider.of<Post>(context, listen: false)
                                      .addVideo(isCamera: true);
                                },
                              ),
                            ],
                          ));
                },
              )
            : SizedBox.shrink(),
        !kIsWeb
            ? SizedBox(
                width: 7.0,
              )
            : SizedBox.shrink(),
        InkWell(
          child: Icon(
            Icons.headphones,
            size: 30.0,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        Spacer(),
        InkWell(
          child: Icon(
            Icons.tag,
            size: 30.0,
          ),
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => SingleChildScrollView(
                child: Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  child: ModalBottomSheet(
                    title: 'Add tags',
                    content: AddTags(),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
