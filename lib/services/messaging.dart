import 'package:flutter/material.dart';
import 'package:tumblrx/models/chatting/chat_message.dart';
import 'package:tumblrx/models/chatting/conversation.dart';

class Messaging extends ChangeNotifier {
  List<Conversation> conversations = [
    Conversation(
        id: '1',
        username: 'GeraltOfRivia',
        avatarUrl:
            'https://www.nicepng.com/png/detail/39-391756_witcher-3-wolf-png-witcher-3-logo.png'),
    Conversation(
        id: '7',
        username: 'RonaldoSiiiiuu',
        avatarUrl:
            'https://img.a.transfermarkt.technology/portrait/big/8198-1631656078.jpg')
  ];
  void sendMessage(String id, String text) {
    int i = conversations.indexWhere((element) => element.id == id);
    conversations[i].addMessage(text, true);
    notifyListeners();
  }

  void receiveMessage(String id, String text) {
    int i = conversations.indexWhere((element) => element.id == id);
    conversations[i].addMessage(text, false);
    notifyListeners();
  }

  List<ChatMessage> getChatMessages(String id) {
    int i = conversations.indexWhere((element) => element.id == id);
    return conversations[i].chatMessages;
  }

  void getConversationsList() {}
}
