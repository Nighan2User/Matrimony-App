import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bright_weddings/services/socket_service.dart';
import 'package:intl/intl.dart';

class ChatDetailScreen extends StatefulWidget {
  final Map<String, dynamic> conversation;

  const ChatDetailScreen({Key? key, required this.conversation}) : super(key: key);

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late SocketService _socketService;
  late String oderId;

  @override
  void initState() {
    super.initState();
    // Initialize socket service
    _socketService = Get.find<SocketService>();
    
    // Generate a unique ID for this conversation partner
    oderId = widget.conversation["id"] ?? widget.conversation["name"].hashCode.toString();
    
    // Connect and join chat room
    _socketService.connect();
    _socketService.joinChatRoom(oderId);
    
    // Load initial messages if any exist in history
    _loadInitialMessages();
  }

  void _loadInitialMessages() {
    // If no messages in socket service, add some initial demo messages
    if (_socketService.messages.isEmpty) {
      final initialMessages = [
        Message(
          id: '1',
          senderId: oderId,
          receiverId: _socketService.currentUserId.value,
          text: "Hi! I saw your profile and loved your travel photos 📸",
          timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
          isMe: false,
        ),
        Message(
          id: '2',
          senderId: _socketService.currentUserId.value,
          receiverId: oderId,
          text: "Thank you! I'm really passionate about travel and photography",
          timestamp: DateTime.now().subtract(const Duration(minutes: 13)),
          isMe: true,
        ),
        Message(
          id: '3',
          senderId: oderId,
          receiverId: _socketService.currentUserId.value,
          text: "That's wonderful! What's your favorite destination so far?",
          timestamp: DateTime.now().subtract(const Duration(minutes: 10)),
          isMe: false,
        ),
      ];
      _socketService.messages.addAll(initialMessages);
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _socketService.leaveChatRoom();
    super.dispose();
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isNotEmpty) {
      _socketService.sendMessage(text, oderId);
      _messageController.clear();
      
      // Scroll to bottom after sending
      Future.delayed(const Duration(milliseconds: 100), () {
        _scrollToBottom();
      });
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  String _formatTime(DateTime timestamp) {
    final now = DateTime.now();
    final diff = now.difference(timestamp);
    
    if (diff.inMinutes < 1) {
      return 'Just now';
    } else if (diff.inHours < 1) {
      return '${diff.inMinutes}m ago';
    } else if (diff.inDays < 1) {
      return DateFormat('HH:mm').format(timestamp);
    } else {
      return DateFormat('MMM d, HH:mm').format(timestamp);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFF8F9FA),
      appBar: _buildAppBar(isDark),
      body: Column(
        children: [
          // Connection Status Banner
          Obx(() => _socketService.isConnected.value
              ? const SizedBox.shrink()
              : Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  color: Colors.orange,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Connecting...',
                        style: GoogleFonts.lato(color: Colors.white),
                      ),
                    ],
                  ),
                )),
          
          // Messages List
          Expanded(
            child: Obx(() {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _scrollToBottom();
              });
              
              return ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: _socketService.messages.length,
                itemBuilder: (context, index) {
                  final message = _socketService.messages[index];
                  final showTime = index == 0 ||
                      _socketService.messages[index - 1].timestamp
                              .difference(message.timestamp)
                              .inMinutes
                              .abs() >
                          5;
                  return _buildMessageBubble(message, showTime, isDark);
                },
              );
            }),
          ),
          
          // Typing Indicator
          Obx(() {
            final isTyping = _socketService.typingUsers[oderId] ?? false;
            if (!isTyping) return const SizedBox.shrink();
            
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Text(
                    '${widget.conversation["name"]} is typing',
                    style: GoogleFonts.lato(
                      fontSize: 12,
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(width: 8),
                  _buildTypingDots(),
                ],
              ),
            );
          }),
          
          // Message Input
          _buildMessageInput(isDark),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(bool isDark) {
    return AppBar(
      backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: isDark ? Colors.white : Colors.black87),
        onPressed: () => Navigator.pop(context),
      ),
      title: Row(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage(widget.conversation["image"]),
              ),
              if (widget.conversation["isOnline"] == true)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: const Color(0xFF4CAF50),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                        width: 2,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.conversation["name"] ?? "Chat",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
              Obx(() {
                final isTyping = _socketService.typingUsers[oderId] ?? false;
                final isOnline = widget.conversation["isOnline"] == true;
                
                return Text(
                  isTyping ? "Typing..." : (isOnline ? "Online" : "Last seen recently"),
                  style: GoogleFonts.lato(
                    fontSize: 12,
                    color: isTyping
                        ? const Color(0xFF4CAF50)
                        : (isOnline ? const Color(0xFF4CAF50) : Colors.grey),
                  ),
                );
              }),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.videocam_outlined, color: isDark ? Colors.white70 : Colors.black54),
          onPressed: () => _showFeatureComingSoon("Video call"),
        ),
        IconButton(
          icon: Icon(Icons.call_outlined, color: isDark ? Colors.white70 : Colors.black54),
          onPressed: () => _showFeatureComingSoon("Voice call"),
        ),
        IconButton(
          icon: Icon(Icons.more_vert, color: isDark ? Colors.white70 : Colors.black54),
          onPressed: () => _showChatOptions(isDark),
        ),
      ],
    );
  }

  Widget _buildMessageBubble(Message message, bool showTime, bool isDark) {
    return Column(
      crossAxisAlignment: message.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        if (showTime)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Center(
              child: Text(
                _formatTime(message.timestamp),
                style: GoogleFonts.lato(
                  fontSize: 12,
                  color: Colors.grey[500],
                ),
              ),
            ),
          ),
        Container(
          margin: EdgeInsets.only(
            bottom: 8,
            left: message.isMe ? 60 : 0,
            right: message.isMe ? 0 : 60,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            gradient: message.isMe
                ? const LinearGradient(
                    colors: [Color(0xFFE91E63), Color(0xFFFF5722)],
                  )
                : null,
            color: message.isMe ? null : (isDark ? const Color(0xFF2A2A2A) : Colors.white),
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(20),
              topRight: const Radius.circular(20),
              bottomLeft: Radius.circular(message.isMe ? 20 : 4),
              bottomRight: Radius.circular(message.isMe ? 4 : 20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(isDark ? 0.2 : 0.05),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                message.text,
                style: GoogleFonts.lato(
                  fontSize: 15,
                  color: message.isMe ? Colors.white : (isDark ? Colors.white : Colors.black87),
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    DateFormat('HH:mm').format(message.timestamp),
                    style: GoogleFonts.lato(
                      fontSize: 10,
                      color: message.isMe ? Colors.white70 : Colors.grey,
                    ),
                  ),
                  if (message.isMe) ...[
                    const SizedBox(width: 4),
                    Icon(
                      message.status == 'read'
                          ? Icons.done_all
                          : (message.status == 'delivered' ? Icons.done_all : Icons.done),
                      size: 14,
                      color: message.status == 'read' ? Colors.blue[200] : Colors.white70,
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTypingDots() {
    return Row(
      children: List.generate(3, (index) {
        return TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: 1),
          duration: Duration(milliseconds: 600 + (index * 200)),
          builder: (context, value, child) {
            return Container(
              margin: const EdgeInsets.only(left: 2),
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: Color.lerp(Colors.grey[300], const Color(0xFF4CAF50), value),
                shape: BoxShape.circle,
              ),
            );
          },
        );
      }),
    );
  }

  Widget _buildMessageInput(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.2 : 0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            GestureDetector(
              onTap: () => _showAttachmentOptions(isDark),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[800] : Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.add, color: Color(0xFFE91E63)),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[800] : Colors.grey[100],
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        style: TextStyle(color: isDark ? Colors.white : Colors.black87),
                        decoration: InputDecoration(
                          hintText: "Type a message...",
                          hintStyle: GoogleFonts.lato(color: Colors.grey),
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            _socketService.sendTypingIndicator(oderId);
                          }
                        },
                        onSubmitted: (_) => _sendMessage(),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.emoji_emotions_outlined,
                        color: isDark ? Colors.grey[400] : Colors.grey,
                      ),
                      onPressed: () => _showFeatureComingSoon("Emoji picker"),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: _sendMessage,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFE91E63), Color(0xFFFF5722)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.send, color: Colors.white, size: 22),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFeatureComingSoon(String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("$feature feature coming soon"),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _showAttachmentOptions(bool isDark) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildAttachmentOption(Icons.image, "Gallery", Colors.purple, isDark),
                  _buildAttachmentOption(Icons.camera_alt, "Camera", Colors.pink, isDark),
                  _buildAttachmentOption(Icons.insert_drive_file, "Document", Colors.blue, isDark),
                  _buildAttachmentOption(Icons.location_on, "Location", Colors.green, isDark),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAttachmentOption(IconData icon, String label, Color color, bool isDark) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        _showFeatureComingSoon(label);
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: GoogleFonts.lato(
              fontSize: 12,
              color: isDark ? Colors.white70 : Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  void _showChatOptions(bool isDark) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              ListTile(
                leading: Icon(Icons.person, color: isDark ? Colors.white70 : Colors.black54),
                title: Text("View Profile", style: GoogleFonts.lato(color: isDark ? Colors.white : Colors.black87)),
                onTap: () {
                  Navigator.pop(context);
                  _showFeatureComingSoon("View Profile");
                },
              ),
              ListTile(
                leading: Icon(Icons.search, color: isDark ? Colors.white70 : Colors.black54),
                title: Text("Search in Chat", style: GoogleFonts.lato(color: isDark ? Colors.white : Colors.black87)),
                onTap: () {
                  Navigator.pop(context);
                  _showFeatureComingSoon("Search in Chat");
                },
              ),
              ListTile(
                leading: Icon(Icons.notifications_off, color: isDark ? Colors.white70 : Colors.black54),
                title: Text("Mute Notifications", style: GoogleFonts.lato(color: isDark ? Colors.white : Colors.black87)),
                onTap: () {
                  Navigator.pop(context);
                  _showFeatureComingSoon("Mute Notifications");
                },
              ),
              ListTile(
                leading: const Icon(Icons.block, color: Colors.red),
                title: Text("Block User", style: GoogleFonts.lato(color: Colors.red)),
                onTap: () {
                  Navigator.pop(context);
                  _showFeatureComingSoon("Block User");
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}
