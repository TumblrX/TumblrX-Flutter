import 'dart:io';
import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/models/chatting/chat_message.dart';
import 'package:tumblrx/models/chatting/conversation.dart';
import 'package:tumblrx/services/api_provider.dart';
import 'package:tumblrx/services/authentication.dart';

class Messaging extends ChangeNotifier {
  ///List of conversations of the user
  List<Conversation> conversations;

  void sendMessage(String userId, String text, BuildContext context) async {
    // int i = conversations.indexWhere((element) => element.userId == userId);
    // conversations[i].addMessage(text, true);
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
    if (i == -1) return [];
    return conversations[i].chatMessages;
  }

  Future<void> getConversationsList(BuildContext context) async {
    conversations = [];

    String endPoint = 'user/chat/reterive-conversations';
    Map<String, String> header = {
      HttpHeaders.authorizationHeader:
          Provider.of<Authentication>(context, listen: false).token
    };
    try {
      final response =
          await ApiHttpRepository.sendGetRequest(endPoint, headers: header);
      print(response.statusCode);
      print(response.body);
      Map<String, dynamic> responseObject =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      for (Map<String, dynamic> conversation in responseObject['data']) {
        conversations.add(Conversation.fromJson(conversation));
      }
    } catch (e) {
      print(e);
    }
    return;
  }

  Future<void> getChatContent(
      BuildContext context, String chatId, String userId) async {
    int i = conversations.indexWhere((element) => element.chatId == chatId);
    if (i == -1) return;
    String endPoint = 'user/chat/reterive-chat/' + chatId;
    Map<String, String> header = {
      HttpHeaders.authorizationHeader:
          Provider.of<Authentication>(context, listen: false).token
    };
    try {
      final response =
          await ApiHttpRepository.sendGetRequest(endPoint, headers: header);
      print(response.statusCode);
      conversations[i].chatMessages = [];
      Map<String, dynamic> responseObject =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      for (Map<String, dynamic> chatMessage in responseObject['messages']) {
        conversations[i]
            .addMessage(chatMessage['text'], chatMessage['senderId'] != userId);
      }
      conversations[i].chatMessages =
          conversations[i].chatMessages.reversed.toList();
    } catch (e) {
      print(e);
    }
    return;
  }
}
