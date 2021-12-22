import 'package:tumblrx/models/chatting/chat_message.dart';
import 'package:tumblrx/services/api_provider.dart';

class Conversation {
  String chatId;
  String userId;
  String username;
  String avatarUrl;
  String lastMessage;
  bool lastMessageIsMe;
  List<ChatMessage> chatMessages = [];
  Conversation.fromJson(Map<String, dynamic> jsonData) {
    if (jsonData.containsKey('chatId'))
      chatId = jsonData['chatId'];
    else
      throw Exception('missing required parameter "chatId"');
    if (jsonData.containsKey('textedUser')) {
      userId = jsonData['textedUser'];
    } else
      throw Exception('missing required parameter "textedUser"');
    if (jsonData.containsKey('blogHandle'))
      username = jsonData['blogHandle'];
    else
      throw Exception('missing required parameter "blogHandle"');
    if (jsonData.containsKey('avatar')) {
      if (jsonData['avatar'] != 'none')
        avatarUrl = ApiHttpRepository.api + jsonData['avatar'];
      else
        avatarUrl = ApiHttpRepository.api +
            "uploads/post/image/post-1639258474966-61b28a610a654cdd7b39171c.jpeg";
    } else
      throw Exception('missing required parameter "avatar"');
    if (jsonData.containsKey('message'))
      lastMessage = jsonData['message'];
    else
      throw Exception('missing required parameter "message"');
    if (jsonData.containsKey('isMe'))
      lastMessageIsMe = jsonData['isMe'];
    else
      throw Exception('missing required parameter "isMe"');
  }
  void addMessage(String text, bool isMe) {
    chatMessages.add(ChatMessage(text: text, isMe: isMe));
  }
}
