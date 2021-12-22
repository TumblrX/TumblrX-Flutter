import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/models/chatting/chat_message.dart';
import 'package:tumblrx/models/chatting/conversation.dart';
import 'package:tumblrx/models/user/user.dart';
import 'package:tumblrx/services/api_provider.dart';
import 'package:tumblrx/services/authentication.dart';

class Messaging extends ChangeNotifier {
  ///List of conversations of the user
  List<Conversation> conversations = [];

  void sendMessage(String userId, String text, BuildContext context) async {
    int i = conversations.indexWhere((element) => element.userId == userId);
    conversations[i].addMessage(text, true);
    String endPoint = 'api/user/chat/send-message';
    Map<String, String> body = {'textMessage': text, 'user2Id': userId};
    Map<String, String> header = {
      HttpHeaders.authorizationHeader:
          Provider.of<Authentication>(context, listen: false).token
    };
    try {
      final response = await ApiHttpRepository.sendPostRequest(endPoint,
          reqBody: body, headers: header);
      print(response.statusCode);
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  void receiveMessage(String chatId, String text) {
    int i = conversations.indexWhere((element) => element.chatId == chatId);
    conversations[i].addMessage(text, false);
    notifyListeners();
  }

  String getChatId(String userId) {
    int i = conversations.indexWhere((element) => element.userId == userId);
    if (i == -1) return null;
    return conversations[i].chatId;
  }

  List<ChatMessage> getChatMessages(String chatId) {
    int i = conversations.indexWhere((element) => element.chatId == chatId);
    return conversations[i].chatMessages;
  }

  Future<void> getConversationsList() async {
    await Future.delayed(Duration(seconds: 1));
    conversations = [
      Conversation(
          chatId: '123',
          userId: '61b26488c3616702bdca4d48',
          username: 'Taher2Bahsa',
          avatarUrl:
              'https://www.nicepng.com/png/detail/39-391756_witcher-3-wolf-png-witcher-3-logo.png'),
      Conversation(
          chatId: '456',
          userId: '61b47bd2bd13dd22af73bd86',
          username: 'Gamal',
          avatarUrl:
              'https://img.a.transfermarkt.technology/portrait/big/8198-1631656078.jpg')
    ];
    return;
  }

  ///returns last message status
  String getLastMessage(String id, BuildContext context) {
    int i = conversations.indexWhere((element) => element.chatId == id);
    String lastMessage = '';
    if (i != -1 && conversations[i].chatMessages.length > 0) {
      lastMessage = conversations[i].chatMessages.last.isMe
          ? Provider.of<User>(context, listen: false).username
          : conversations[i].username;
      lastMessage = '$lastMessage: ${conversations[i].chatMessages.last.text}';
    }
    return lastMessage;
  }
}
