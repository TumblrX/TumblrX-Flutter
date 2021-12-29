import 'dart:io';
import 'dart:convert' as convert;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tumblrx/global.dart';
import 'package:tumblrx/models/chatting/chat_message.dart';
import 'package:tumblrx/models/chatting/conversation.dart';
import 'package:tumblrx/services/api_provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

///Class that manages all chat services
class Messaging extends ChangeNotifier {
  ///List of conversations of the user
  List<Conversation> conversations;

  ///Socket object
  IO.Socket socket;

  ///User ID
  String myId;

  ///Token
  String token; //to be removed probably

  ///Sends a message to the database to the user with [userId]
  ///[text] is the message content, and [context] is used to show error message
  void sendMessage(String receiverId, String text, BuildContext context) {
    final SnackBar errorSnackBar = SnackBar(
      backgroundColor: Colors.red,
      content: Text('Something went wrong :( .. Check internet connection...'),
    );
    try {
      if (socket.connected) {
        Map<String, String> data = {'content': text, 'receiverId': receiverId};
        socket.emit('private message', data);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
    }
  }

  ///Receives message from data sent by socket io
  void receiveMessage(String text, String senderId, String receiverId) {
    bool isMe = senderId == myId;
    String otherUser = isMe ? receiverId : senderId;
    int i = conversations.indexWhere((element) => element.userId == otherUser);
    if (i == -1) {
      getConversationsList(true, otherUser); //first time message
      return;
    }
    conversations[i].addMessage(text, isMe,
        DateTime.now().add(Duration(hours: -2)).toIso8601String() + 'z');
    notifyListeners();
  }

  ///returns chat Id from the other [userId]
  ///returns null if the conversation doesn't exist
  String getChatId(String userId) {
    int i = conversations.indexWhere((element) => element.userId == userId);
    if (i == -1) return null;
    return conversations[i].chatId;
  }

  ///returns the whole chat messages of a conversation with [chatId]
  List<ChatMessage> getChatMessages(String userId) {
    int i = conversations.indexWhere((element) => element.userId == userId);
    if (i == -1) return [];
    return conversations[i].chatMessages;
  }

  ///returns list of conversations of the current user
  Future<void> getConversationsList(
      [bool retrieveChatFirstTime = false, String userId]) async {
    conversations = [];

    String endPoint = 'user/chat/reterive-conversations';
    Map<String, String> header = {HttpHeaders.authorizationHeader: token};
    try {
      final response =
          await apiClient.sendGetRequest(endPoint, headers: header);
      // print(response.statusCode);
      // print(response.body);
      logger.d(response);
      for (Map<String, dynamic> conversation in response['data']) {
        conversations.add(Conversation.fromJson(conversation));
      }
      if (retrieveChatFirstTime) {
        getChatContent(userId);
      }
    } catch (e) {
      print(e);
    }
    return;
  }

  ///retrieves chat messages from the database from a conversation with [chatId] with user of [userId]
  Future<void> getChatContent(String userId) async {
    int i = conversations.indexWhere((element) => element.userId == userId);
    if (i == -1) return;
    String endPoint = 'user/chat/reterive-chat/' + userId;
    Map<String, String> header = {HttpHeaders.authorizationHeader: token};
    try {
      final response =
          await apiClient.sendGetRequest(endPoint, headers: header);
      logger.d(response['statuscode']);
      logger.d(response);
      conversations[i].chatMessages = [];
      for (Map<String, dynamic> chatMessage in response['messages']) {
        conversations[i].addMessage(chatMessage['text'],
            chatMessage['senderId'] != userId, chatMessage['createdAt']);
      }
      conversations[i].chatMessages =
          conversations[i].chatMessages.reversed.toList();
    } catch (e) {
      print(e);
    }
    notifyListeners();
    return;
  }

  ///Connects to socket server upon login and saves [userId] and [token] to be used in requests
  void connectToServer(String userId, String token) {
    this.myId = userId;
    this.token = token;
    socket = IO.io(
        'http://tumblrx.me:6600',
        !kIsWeb
            ? IO.OptionBuilder()
                .setTransports(['websocket']) // for Flutter or Dart VM
                .setExtraHeaders({'authorization': token})
                .disableAutoConnect() // disable auto-connection
                .build()
            : IO.OptionBuilder()
                .setExtraHeaders({'authorization': token})
                .disableAutoConnect() // disable auto-connection
                .build());
    socket = socket.connect();
    print('connection id: ' + userId);
    socket.onConnect((_) {
      print('connect');
    });
    socket.on('privateMessage', (data) {
      print('message recieved');
      receiveMessage(data['content'], data['senderId'], data['receiverId']);
      print(data);
    });

    socket.onDisconnect((_) => {print('disconnect')});
  }

  ///called on logout to disconnect from socket server
  void disconnect() {
    socket.off('privateMessage');
    socket.disconnect();
  }
}
