import 'dart:io';
import 'dart:convert' as convert;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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

  ///Number of unseen messages
  int totalUnseenMessage = 0;

  ///List of suggested conversations with users in new conversation screen
  List<Map<String, String>> suggestedConversations = [
    {
      'username': 'Taher2Bahsa',
      'userId': '61b26488c3616702bdca4d48',
      'userAvatar':
          'https://assets.tumblr.com/images/default_avatar/cube_open_128.png'
    },
    {
      'username': 'Gamal',
      'userId': '61b47bd2bd13dd22af73bd86',
      'userAvatar':
          'https://assets.tumblr.com/images/default_avatar/cube_open_128.png'
    },
    {
      'username': 'Example',
      'userId': '61b46c20bd13dd22af73bd01',
      'userAvatar':
          'https://assets.tumblr.com/images/default_avatar/cube_open_128.png'
    },
    {
      'username': 'bishoytest123',
      'userId': '61ca14deb6ee95ef1f690e44',
      'userAvatar': ApiHttpRepository.api +
          'uploads/blog/blog-1640644817494-61ca14deb6ee95ef1f690e47.jpeg'
    },
    {
      'username': 'Taher13',
      'userId': '61b4c1a32de31c0235abc090',
      'userAvatar':
          'https://assets.tumblr.com/images/default_avatar/cube_open_128.png'
    },
    {
      'username': 'peter',
      'userId': '61b4c39e2de31c0235abc12e',
      'userAvatar':
          'https://assets.tumblr.com/images/default_avatar/cube_open_128.png'
    },
    {
      'username': 'YousefElshabrawy',
      'userId': '61b72b2fcf6c2aaab9a1e406',
      'userAvatar':
          'https://assets.tumblr.com/images/default_avatar/cube_open_128.png'
    },
    {
      'username': 'Andrew',
      'userId': '61b76ec7cf6c2aaab9a1e484',
      'userAvatar':
          'https://assets.tumblr.com/images/default_avatar/cube_open_128.png'
    },
    {
      'username': 'ahmednossir',
      'userId': '61c353ebf50be9d1d297d959',
      'userAvatar':
          'https://assets.tumblr.com/images/default_avatar/cube_open_128.png'
    }
  ];

  ///All conversations users to search from
  List<Map<String, String>> allSuggestedConversations = [
    {
      'username': 'Taher2Bahsa',
      'userId': '61b26488c3616702bdca4d48',
      'userAvatar':
          'https://assets.tumblr.com/images/default_avatar/cube_open_128.png'
    },
    {
      'username': 'Gamal',
      'userId': '61b47bd2bd13dd22af73bd86',
      'userAvatar':
          'https://assets.tumblr.com/images/default_avatar/cube_open_128.png'
    },
    {
      'username': 'Example',
      'userId': '61b46c20bd13dd22af73bd01',
      'userAvatar':
          'https://assets.tumblr.com/images/default_avatar/cube_open_128.png'
    },
    {
      'username': 'bishoytest123',
      'userId': '61ca14deb6ee95ef1f690e44',
      'userAvatar': ApiHttpRepository.api +
          'uploads/blog/blog-1640644817494-61ca14deb6ee95ef1f690e47.jpeg'
    },
    {
      'username': 'Taher13',
      'userId': '61b4c1a32de31c0235abc090',
      'userAvatar':
          'https://assets.tumblr.com/images/default_avatar/cube_open_128.png'
    },
    {
      'username': 'peter',
      'userId': '61b4c39e2de31c0235abc12e',
      'userAvatar':
          'https://assets.tumblr.com/images/default_avatar/cube_open_128.png'
    },
    {
      'username': 'YousefElshabrawy',
      'userId': '61b72b2fcf6c2aaab9a1e406',
      'userAvatar':
          'https://assets.tumblr.com/images/default_avatar/cube_open_128.png'
    },
    {
      'username': 'Andrew',
      'userId': '61b76ec7cf6c2aaab9a1e484',
      'userAvatar':
          'https://assets.tumblr.com/images/default_avatar/cube_open_128.png'
    },
    {
      'username': 'ahmednossir',
      'userId': '61c353ebf50be9d1d297d959',
      'userAvatar':
          'https://assets.tumblr.com/images/default_avatar/cube_open_128.png'
    }
  ];

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
    if (senderId != myId) {
      totalUnseenMessage += 1;
    }
    print(totalUnseenMessage);
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
    totalUnseenMessage = 0;
    String endPoint = 'user/chat/reterive-conversations';
    Map<String, String> header = {HttpHeaders.authorizationHeader: token};
    try {
      final response =
          await ApiHttpRepository.sendGetRequest(endPoint, headers: header);
      Map<String, dynamic> responseObject =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      print(responseObject);
      if (response.statusCode == 200 || response.statusCode == 201) {
        for (Map<String, dynamic> conversation in responseObject['data']) {
          conversations.add(Conversation.fromJson(conversation));
        }
      }
      if (retrieveChatFirstTime) {
        getChatContent(userId);
      }
    } catch (e) {
      print(e);
    }
    notifyListeners();
    return;
  }

  ///retrieves chat messages from the database from a conversation with [chatId] with user of [userId]
  Future<void> getChatContent(String userId) async {
    int i = conversations.indexWhere((element) => element.userId == userId);
    if (i == -1) return;
    String endPoint = 'user/chat/reterive-chat/' + userId;
    print(endPoint);
    Map<String, String> header = {HttpHeaders.authorizationHeader: token};
    try {
      final response =
          await ApiHttpRepository.sendGetRequest(endPoint, headers: header);
      print(response.statusCode);
      conversations[i].chatMessages = [];
      Map<String, dynamic> responseObject =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 200 || response.statusCode == 201) {
        for (Map<String, dynamic> chatMessage in responseObject['messages']) {
          conversations[i].addMessage(chatMessage['text'],
              chatMessage['senderId'] != userId, chatMessage['createdAt']);
        }
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

  ///Delete conversation with [userId]
  void deleteConversation(BuildContext context, String userId) async {
    int i = conversations.indexWhere((element) => element.userId == userId);
    if (i == -1) return;
    String endPoint = 'api/user/chat/delete-chat/' + userId;
    print(endPoint);
    Map<String, String> header = {'Authorization': token};
    final SnackBar errorSnackBar = SnackBar(
      backgroundColor: Colors.red,
      content: Text('Something went wrong :( .. Check internet connection...'),
    );
    try {
      final response =
          await ApiHttpRepository.sendDeleteRequest(endPoint, header);
      print(response.body);
      if (response.statusCode == 200) {
        Navigator.pop(context);
        Navigator.pop(context);
        conversations.removeAt(i);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
    }
    notifyListeners();
    return;
  }

  ///Takes user input [username] and searches in [allSuggestedConversations] to suggest all possible conversations.
  void searchSuggestedConversations(String username) {
    suggestedConversations = [];
    for (Map<String, String> conversation in allSuggestedConversations) {
      if (conversation['username']
          .contains(RegExp(username, caseSensitive: false)))
        suggestedConversations.add(conversation);
    }
    notifyListeners();
  }

  ///called on logout to disconnect from socket server
  void disconnect() {
    socket.off('privateMessage');
    socket.disconnect();
  }
}
