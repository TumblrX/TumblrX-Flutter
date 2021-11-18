import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/components/createpost/tags_list_view.dart';
import 'package:tumblrx/services/creating_post.dart';

import '../modal_bottom_sheet.dart';
import 'add_tags.dart';

///A Widget that shows chosen tags if available or option to add tags.
class PostTags extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Provider.of<CreatingPost>(context).chosenHashtags.length == 0
          ? TextButton(
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 5.0,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.add,
                      size: 30.0,
                      color: Colors.black,
                    ),
                    Text(
                      'Add tags to help people find your post',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.black12),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
              ),
              onPressed: () {
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
            )
          : GestureDetector(
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
              child: Container(
                height: 50.0,
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                          Container(
                            width: 40.0,
                            height: 40.0,
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            child: Icon(
                              Icons.add,
                              color: Colors.black,
                              size: 30.0,
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Flexible(
                            child: TagsListView(
                                tagsList: Provider.of<CreatingPost>(context)
                                    .chosenHashtags,
                                isPostView: true),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
