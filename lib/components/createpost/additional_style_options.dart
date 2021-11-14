import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/services/post.dart';

import 'color_choice.dart';

class AdditionalStyleOptions extends StatelessWidget {
  final int index;
  AdditionalStyleOptions({this.index});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF757575),
      child: Container(
        padding: MediaQuery.of(context).viewInsets,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  right: 8.0,
                  top: 8.0,
                  bottom: 4.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ColorChoice(textFieldIndex: index, color: Colors.black),
                    ColorChoice(textFieldIndex: index, color: Colors.red),
                    ColorChoice(textFieldIndex: index, color: Colors.orange),
                    ColorChoice(textFieldIndex: index, color: Colors.green),
                    ColorChoice(textFieldIndex: index, color: Colors.lightBlue),
                    ColorChoice(textFieldIndex: index, color: Colors.purple),
                    ColorChoice(
                        textFieldIndex: index, color: Colors.pinkAccent),
                  ],
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  right: 8.0,
                  top: 4.0,
                  bottom: 8.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      child: IgnorePointer(
                        child: Icon(
                          Icons.text_format,
                          size: 30.0,
                        ),
                      ),
                      onTap: () {
                        Provider.of<Post>(context, listen: false)
                            .nextTextStyle(index);
                      },
                    ),
                    Spacer(),
                    InkWell(
                      child: IgnorePointer(
                        child: Icon(
                          Icons.format_bold,
                          size: 30.0,
                        ),
                      ),
                      onTap: () {
                        Provider.of<Post>(context, listen: false)
                            .setBold(index);
                      },
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    InkWell(
                      child: Icon(
                        Icons.format_italic,
                        size: 30.0,
                      ),
                      onTap: () {
                        Provider.of<Post>(context, listen: false)
                            .setItalic(index);
                      },
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    InkWell(
                      child: Icon(
                        Icons.strikethrough_s,
                        size: 30.0,
                      ),
                      onTap: () {
                        Provider.of<Post>(context, listen: false)
                            .setLineThrough(index);
                      },
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
