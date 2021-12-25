import 'package:tumblrx/models/chatting/chat_message.dart';
import 'package:tumblrx/services/api_provider.dart';

///Model of a conversation
class Conversation {
  ///chat id in the database
  String chatId;

  ///the other user id
  String userId;

  ///username of the other user
  String username;

  ///avatar Url of the other user
  String avatarUrl;

  ///last message sent in the conversation
  String lastMessage;

  ///boolean value if the last message is sent by the user
  bool lastMessageIsMe;

  ///Time of the last sent message
  String lastMessageTime;

  ///List of chat Messages Objects in the conversation
  List<ChatMessage> chatMessages = [];

  ///Constructor that takes json object and assigns the object attributes
  Conversation.fromJson(Map<String, dynamic> jsonData) {
    if (jsonData.containsKey('chatId'))
      chatId = jsonData['chatId'];
    else
      throw Exception('missing required parameter "chatId"');
    if (jsonData.containsKey('textedUser')) {
      userId = jsonData['textedUser'];
    } else
      throw Exception('missing required parameter "textedUser"');
    if (jsonData.containsKey('messageDate')) {
      lastMessageTime = jsonData['messageDate'];
    } else
      throw Exception('missing required parameter "messageDate"');
    if (jsonData.containsKey('blogHandle'))
      username = jsonData['blogHandle'];
    else
      throw Exception('missing required parameter "blogHandle"');
    if (jsonData.containsKey('avatar')) {
      if (jsonData['avatar'] != 'none') {
        avatarUrl = jsonData['avatar'];
        if (avatarUrl.startsWith('uploads'))
          avatarUrl = ApiHttpRepository.api + avatarUrl;
      } else
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

  ///Adds messages to to the list of chat messages
  void addMessage(String text, bool isMe, String messageTime) {
    chatMessages
        .add(ChatMessage(text: text, isMe: isMe, messageTime: messageTime));
  }
}
