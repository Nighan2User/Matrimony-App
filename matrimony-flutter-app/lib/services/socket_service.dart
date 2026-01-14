import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:uuid/uuid.dart';

class Message {
  final String id;
  final String senderId;
  final String receiverId;
  final String text;
  final DateTime timestamp;
  final bool isMe;
  final String status; // sent, delivered, read

  Message({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.text,
    required this.timestamp,
    required this.isMe,
    this.status = 'sent',
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'senderId': senderId,
        'receiverId': receiverId,
        'text': text,
        'timestamp': timestamp.toIso8601String(),
      };

  factory Message.fromJson(Map<String, dynamic> json, String currentUserId) {
    return Message(
      id: json['id'] ?? const Uuid().v4(),
      senderId: json['senderId'] ?? '',
      receiverId: json['receiverId'] ?? '',
      text: json['text'] ?? '',
      timestamp: json['timestamp'] != null
          ? DateTime.parse(json['timestamp'])
          : DateTime.now(),
      isMe: json['senderId'] == currentUserId,
      status: json['status'] ?? 'sent',
    );
  }
}

class SocketService extends GetxController {
  static SocketService get to => Get.find<SocketService>();

  IO.Socket? _socket;
  final RxBool isConnected = false.obs;
  final RxString currentUserId = ''.obs;
  final RxString currentChatRoom = ''.obs;
  final RxList<Message> messages = <Message>[].obs;
  final RxMap<String, bool> typingUsers = <String, bool>{}.obs;
  final RxMap<String, List<Message>> chatHistory = <String, List<Message>>{}.obs;

  // Server URL - Change this to your Socket.IO server URL
  // For demo purposes, we'll use a mock server or local server
  static const String serverUrl = 'https://your-socket-server.com';
  // For local testing: 'http://localhost:3000'

  // Demo mode flag - set to true for offline demo functionality
  final bool isDemoMode = true;

  @override
  void onInit() {
    super.onInit();
    // Generate a unique user ID for this session
    currentUserId.value = const Uuid().v4();
  }

  void connect() {
    if (isDemoMode) {
      // Demo mode - simulate connection
      isConnected.value = true;
      print('Socket.IO Demo Mode: Connected');
      return;
    }

    try {
      _socket = IO.io(
        serverUrl,
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .setExtraHeaders({'userId': currentUserId.value})
            .build(),
      );

      _socket!.connect();

      _socket!.onConnect((_) {
        isConnected.value = true;
        print('Socket.IO Connected');
        _socket!.emit('user_online', {'userId': currentUserId.value});
      });

      _socket!.onDisconnect((_) {
        isConnected.value = false;
        print('Socket.IO Disconnected');
      });

      _socket!.onConnectError((error) {
        print('Socket.IO Connection Error: $error');
        isConnected.value = false;
      });

      // Listen for incoming messages
      _socket!.on('receive_message', (data) {
        _handleIncomingMessage(data);
      });

      // Listen for typing indicators
      _socket!.on('user_typing', (data) {
        final String oderId = data['userId'];
        typingUsers[oderId] = true;
        // Auto-remove typing indicator after 3 seconds
        Future.delayed(const Duration(seconds: 3), () {
          typingUsers[oderId] = false;
        });
      });

      // Listen for message status updates
      _socket!.on('message_delivered', (data) {
        _updateMessageStatus(data['messageId'], 'delivered');
      });

      _socket!.on('message_read', (data) {
        _updateMessageStatus(data['messageId'], 'read');
      });
    } catch (e) {
      print('Socket.IO Error: $e');
    }
  }

  void disconnect() {
    if (isDemoMode) {
      isConnected.value = false;
      return;
    }
    _socket?.disconnect();
    _socket?.dispose();
    isConnected.value = false;
  }

  void joinChatRoom(String oderId) {
    final roomId = _generateRoomId(currentUserId.value, oderId);
    currentChatRoom.value = roomId;

    // Load chat history for this room
    if (chatHistory.containsKey(roomId)) {
      messages.value = List.from(chatHistory[roomId]!);
    } else {
      messages.clear();
      chatHistory[roomId] = [];
    }

    if (!isDemoMode && _socket != null) {
      _socket!.emit('join_room', {'roomId': roomId, 'userId': currentUserId.value});
    }
  }

  void leaveChatRoom() {
    if (!isDemoMode && _socket != null && currentChatRoom.value.isNotEmpty) {
      _socket!.emit('leave_room', {'roomId': currentChatRoom.value});
    }
    currentChatRoom.value = '';
  }

  void sendMessage(String text, String receiverId) {
    if (text.trim().isEmpty) return;

    final message = Message(
      id: const Uuid().v4(),
      senderId: currentUserId.value,
      receiverId: receiverId,
      text: text.trim(),
      timestamp: DateTime.now(),
      isMe: true,
      status: 'sent',
    );

    // Add to local messages immediately
    messages.add(message);

    // Save to chat history
    final roomId = _generateRoomId(currentUserId.value, receiverId);
    if (!chatHistory.containsKey(roomId)) {
      chatHistory[roomId] = [];
    }
    chatHistory[roomId]!.add(message);

    if (isDemoMode) {
      // Demo mode - simulate response after delay
      _simulateResponse(receiverId);
    } else if (_socket != null) {
      // Send via socket
      _socket!.emit('send_message', {
        'roomId': currentChatRoom.value,
        ...message.toJson(),
      });
    }
  }

  void sendTypingIndicator(String receiverId) {
    if (!isDemoMode && _socket != null) {
      _socket!.emit('typing', {
        'roomId': currentChatRoom.value,
        'userId': currentUserId.value,
      });
    }
  }

  void markMessagesAsRead(String oderId) {
    if (!isDemoMode && _socket != null) {
      _socket!.emit('mark_read', {
        'roomId': currentChatRoom.value,
        'userId': currentUserId.value,
      });
    }
  }

  void _handleIncomingMessage(dynamic data) {
    final message = Message.fromJson(data, currentUserId.value);
    messages.add(message);

    // Save to chat history
    final roomId = _generateRoomId(currentUserId.value, message.senderId);
    if (!chatHistory.containsKey(roomId)) {
      chatHistory[roomId] = [];
    }
    chatHistory[roomId]!.add(message);

    // Emit delivery confirmation
    if (_socket != null) {
      _socket!.emit('message_delivered', {'messageId': message.id});
    }
  }

  void _updateMessageStatus(String messageId, String status) {
    final index = messages.indexWhere((m) => m.id == messageId);
    if (index != -1) {
      final oldMessage = messages[index];
      messages[index] = Message(
        id: oldMessage.id,
        senderId: oldMessage.senderId,
        receiverId: oldMessage.receiverId,
        text: oldMessage.text,
        timestamp: oldMessage.timestamp,
        isMe: oldMessage.isMe,
        status: status,
      );
    }
  }

  String _generateRoomId(String oderId1, String oderId2) {
    final ids = [oderId1, oderId2]..sort();
    return '${ids[0]}_${ids[1]}';
  }

  // Demo mode: Simulate responses
  void _simulateResponse(String oderId) {
    final responses = [
      "That's interesting! Tell me more 😊",
      "I completely agree with you!",
      "Sounds great! When are you free?",
      "Haha, that's funny! 😄",
      "I'd love to hear more about that",
      "That's a wonderful idea!",
      "Looking forward to it! 🎉",
      "Thanks for sharing that with me",
    ];

    // Simulate typing indicator
    typingUsers[oderId] = true;

    Future.delayed(const Duration(seconds: 2), () {
      typingUsers[oderId] = false;

      final response = Message(
        id: const Uuid().v4(),
        senderId: oderId,
        receiverId: currentUserId.value,
        text: responses[DateTime.now().millisecond % responses.length],
        timestamp: DateTime.now(),
        isMe: false,
        status: 'delivered',
      );

      messages.add(response);

      // Save to chat history
      final roomId = _generateRoomId(currentUserId.value, oderId);
      if (!chatHistory.containsKey(roomId)) {
        chatHistory[roomId] = [];
      }
      chatHistory[roomId]!.add(response);
    });
  }

  @override
  void onClose() {
    disconnect();
    super.onClose();
  }
}
