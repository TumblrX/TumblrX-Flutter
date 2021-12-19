import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:styled_text/styled_text.dart';
import 'package:tumblrx/utilities/constants.dart';
import 'package:tumblrx/utilities/text_format.dart';

//import 'package:clipboard/clipboard.dart';
class TextBlockWidget extends StatelessWidget {
  final String _text;
  final String _sharableText;
  const TextBlockWidget(
      {Key key, @required String text, @required String sharableText})
      : _text = text,
        _sharableText = sharableText,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        EdgeInsets padding = MediaQuery.of(context).padding;
        double pads = padding.left + padding.right;
        double width = (MediaQuery.of(context).size.width - pads) * 0.5;
        showDialog(
            barrierColor: Colors.black.withOpacity(.5),
            context: context,
            builder: (context) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        height: 50,
                        color: Colors.white,
                        child: TextButton(
                          onPressed: () async {
                            await FlutterClipboard.copy(_sharableText);
                            showSnackBarMessage(
                                context, 'Copied to clipboard!', Colors.green);
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Copy',
                            style: TextStyle(
                                color: Colors.black54,
                                letterSpacing: 1.5,
                                fontSize: 20),
                          ),
                          style: ButtonStyle(
                              fixedSize: MaterialStateProperty.all(
                                  Size.fromWidth(width))),
                        )),
                  ],
                ));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StyledText(
          text: _text,
          tags: formattingTags(),
        ),
      ),
    );
  }
}
