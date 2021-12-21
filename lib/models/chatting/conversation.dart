import 'package:tumblrx/models/chatting/chat_message.dart';

class Conversation {
  String id;
  String username;
  String avatarUrl;
  List<ChatMessage> chatMessages = [];
  Conversation({this.id, this.username, this.avatarUrl});
  void addMessage(String text, bool isMe) {
    chatMessages.add(ChatMessage(text: text, isMe: isMe));
  }
}
