import 'dart:io';
import 'dart:convert' as convert;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/models/chatting/chat_message.dart';
import 'package:tumblrx/models/chatting/conversation.dart';
import 'package:tumblrx/services/api_provider.dart';
import 'package:tumblrx/services/authentication.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

///Class that manages all chat services
class Messaging extends ChangeNotifier {
  ///List of conversations of the user
  List<Conversation> conversations;

  ///Socket object
  IO.Socket socket;

  ///User ID
  String userId;

  ///Sends a message to the database to the user with [userId]
  ///[text] is the message content
  void sendMessage(String receiverId, String text) {
    // int i = conversations.indexWhere((element) => element.userId == userId);
    // conversations[i].addMessage(text, true);
    // String endPoint = 'api/user/chat/send-message';
    // Map<String, String> body = {'textMessage': text, 'user2Id': userId};
    // Map<String, String> header = {
    //   HttpHeaders.authorizationHeader:
    //       Provider.of<Authentication>(context, listen: false).token
    // };
    try {
      // final response = await ApiHttpRepository.sendPostRequest(endPoint,
      //         reqBody: body, headers: header)
      //     .then((value) => sendMessageToSocket(myId, userId, text));
      if (socket.connected) {
        Map<String, String> data = {'content': text, 'receiverId': receiverId};
        socket.emit('private message', data);
      }
    } catch (e) {
      print(e);
    }
    //getChatContent(context, chatId, userId);
  }

  ///Receives message from data sent by socket io
  void receiveMessage(String text, String senderId, String receiverId) {
    bool isMe = senderId == userId;
    String otherUser = isMe ? receiverId : senderId;
    int i = conversations.indexWhere((element) => element.userId == otherUser);

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
  List<ChatMessage> getChatMessages(String chatId) {
    int i = conversations.indexWhere((element) => element.chatId == chatId);
    if (i == -1) return [];
    return conversations[i].chatMessages;
  }

  ///returns list of conversations of the current user
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
      // print(response.statusCode);
      // print(response.body);
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

  ///retrieves chat messages from the database from a conversation with [chatId] with user of [userId]
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
        conversations[i].addMessage(chatMessage['text'],
            chatMessage['senderId'] != userId, chatMessage['createdAt']);
      }
      conversations[i].chatMessages =
          conversations[i].chatMessages.reversed.toList();
    } catch (e) {
      print(e);
    }
    return;
  }

  void connectToServer(String userId, String token) {
    this.userId = userId;
    socket = IO.io(
        'http://tumblrx.me:6600',
        !kIsWeb
            ? IO.OptionBuilder()
                .setTransports(['websocket']) // for Flutter or Dart VM
                .setExtraHeaders({'authorization': token})
                .disableAutoConnect() // disable auto-connection
                .build()
            : IO.OptionBuilder()
                //.setTransports(['websocket']) // for Flutter or Dart VM
                .setExtraHeaders({'authorization': token})
                .disableAutoConnect() // disable auto-connection
                .build());
    socket = socket.connect();
    print('connection id: ' + userId);
    socket.onConnect((_) {
      print('connect');
      //socket.emit('userid', userId);
    });
    socket.on('privateMessage', (data) {
      print('message recieved');
      receiveMessage(data['content'], data['senderId'], data['receiverId']);
      print(data);
    });

    socket.onDisconnect((_) => {print('disconnect')});
  }

  void disconnect() {
    socket.off('privateMessage');
    socket.disconnect();
  }
}
