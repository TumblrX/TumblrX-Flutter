import 'package:flutter/material.dart';
import 'package:tumblrx/components/chatting/square_avatar.dart';
import 'package:tumblrx/utilities/time_format_to_view.dart';

///shows the message widget
class MessageBubble extends StatelessWidget {
  ///content of the message
  final String text;

  ///username of message sender
  final String sender;

  ///avatar url of message sender
  final String senderAvatar;

  ///if the user is the message sender
  final bool isMe;

  ///if the sender of the previous message is the same
  final bool isPreviousSame;

  ///time of the message
  final String messageTime;

  ///Checks if previous message time is bigger than 30 minutes
  ///if there is no previous message it is true
  final bool isPreviousTimeBig;

  MessageBubble(
      {this.text,
      this.sender,
      this.senderAvatar,
      this.isMe,
      this.isPreviousSame,
      this.messageTime,
      this.isPreviousTimeBig});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        isPreviousTimeBig
            ? Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  changeTimeFormat(messageTime),
                  style: TextStyle(color: Colors.black54),
                ),
              )
            : SizedBox.shrink(),
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            !isMe
                ? !isPreviousSame
                    ? SquareAvatar(
                        avatarUrl: senderAvatar,
                      )
                    : SizedBox(
                        width: 40.0,
                        height: 40.0,
                      )
                : SizedBox.shrink(),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Padding(
                padding: EdgeInsets.only(
                  top: isPreviousSame ? 0.0 : 5.0,
                ),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.only(
                    topLeft: isMe
                        ? Radius.circular(15.0)
                        : !isPreviousSame
                            ? Radius.circular(0.0)
                            : Radius.circular(15.0),
                    bottomLeft: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0),
                    topRight: isMe
                        ? !isPreviousSame
                            ? Radius.circular(0.0)
                            : Radius.circular(15.0)
                        : Radius.circular(15.0),
                  ),
                  color: isMe ? Colors.lightBlueAccent : Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 10.0,
                    ),
                    child: Column(
                      crossAxisAlignment: isMe
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        !isPreviousSame
                            ? Text(
                                sender,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: isMe ? Colors.white : Colors.black87,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : SizedBox.shrink(),
                        Text(
                          text,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: isMe ? Colors.white : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            isMe
                ? !isPreviousSame
                    ? SquareAvatar(
                        avatarUrl: senderAvatar,
                      )
                    : SizedBox(
                        width: 40.0,
                        height: 40.0,
                      )
                : SizedBox.shrink(),
          ],
        ),
      ],
    );
  }
}
