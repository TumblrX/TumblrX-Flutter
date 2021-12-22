import 'package:tumblrx/models/chatting/chat_message.dart';

class Conversation {
  String chatId;
  String userId;
  String username;
  String avatarUrl;
  List<ChatMessage> chatMessages = [];
  Conversation({this.chatId, this.userId, this.username, this.avatarUrl});
  void addMessage(String text, bool isMe) {
    chatMessages.add(ChatMessage(text: text, isMe: isMe));
  }
}
