import 'package:flutter/material.dart';
import 'package:styled_text/styled_text.dart';
import 'package:tumblrx/utilities/text_format.dart';

//import 'package:clipboard/clipboard.dart';
class TextBlockWidget extends StatelessWidget {
  final String _text;
  const TextBlockWidget({Key key, @required String text})
      : _text = text,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        EdgeInsets padding = MediaQuery.of(context).padding;
        double pads = padding.left + padding.right;
        double width = (MediaQuery.of(context).size.width - pads) * 0.7;
        showDialog(
            context: context,
            builder: (context) => Container(
                  width: width,
                  child: TextButton(
                    onPressed: () {
                      RegExp regExp = new RegExp(r'<.*>');

//                      _text.replaceAllMapped(from, (match) => null)
                      // FlutterClipboard.copy(_text).then(()=>
                      //showSnackBarMessage(context, 'Copied to clipboard!',
                      // Colors.black.withOpacity(0.4)));
                    },
                    child: Text('Copy'),
                    style: ButtonStyle(
                        fixedSize:
                            MaterialStateProperty.all(Size.fromWidth(width))),
                  ),
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
