///Chat Message Model class
class ChatMessage {
  ///Content of the message
  String text;

  ///boolean value that determines if the message is sent by the user himself or the other user
  bool isMe;

  ///time of the message
  String messageTime;

  ChatMessage({this.isMe, this.text, this.messageTime});
}
