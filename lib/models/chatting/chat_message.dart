///Chat Message Model class
class ChatMessage {
  ///Content of the message
  String text;

  ///boolean value that determines if the message is sent by the user or the other user
  bool isMe;
  ChatMessage({this.isMe, this.text});
}
