import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bright_weddings/Component/Navigation/bottom_nav_bar.dart';
import 'package:bright_weddings/View/Dashboard/chat_detail_screen.dart';

class Chat extends StatelessWidget {
  const Chat({super.key});

  @override
  Widget build(BuildContext context) {
    return const ChatPage();
  }
}

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  final List<Map<String, dynamic>> conversations = [
    {
      "id": "user_nandana_001",
      "name": "Nandana",
      "image": "assets/images/profile1.jpg",
      "lastMessage": "That sounds wonderful! Let's plan for the weekend 😊",
      "time": "Just now",
      "unread": 2,
      "isOnline": true,
      "isTyping": false,
    },
    {
      "id": "user_priya_002",
      "name": "Priya",
      "image": "assets/images/profile3.jpg",
      "lastMessage": "I love that book too! Have you read the sequel?",
      "time": "5 mins ago",
      "unread": 0,
      "isOnline": true,
      "isTyping": false,
    },
    {
      "id": "user_sneha_003",
      "name": "Sneha",
      "image": "assets/images/profile5.jpg",
      "lastMessage": "The art exhibition was amazing!",
      "time": "30 mins ago",
      "unread": 1,
      "isOnline": false,
      "isTyping": false,
    },
    {
      "id": "user_arjun_004",
      "name": "Arjun",
      "image": "assets/images/profile2.jpg",
      "lastMessage": "Thanks for the travel recommendations!",
      "time": "2 hours ago",
      "unread": 0,
      "isOnline": false,
      "isTyping": false,
    },
    {
      "id": "user_rahul_005",
      "name": "Rahul",
      "image": "assets/images/profile4.jpg",
      "lastMessage": "See you at the meetup tomorrow",
      "time": "Yesterday",
      "unread": 0,
      "isOnline": false,
      "isTyping": false,
    },
  ];

  final List<Map<String, dynamic>> communityGroups = [
    {
      "name": "Travel Enthusiasts",
      "members": 320,
      "image": "assets/images/profile1.jpg",
      "lastMessage": "Anyone planning a trip to Goa?",
      "isActive": true,
    },
    {
      "name": "Book Club",
      "members": 180,
      "image": "assets/images/profile3.jpg",
      "lastMessage": "This week's book is 'Atomic Habits'",
      "isActive": false,
    },
    {
      "name": "Foodies Corner",
      "members": 450,
      "image": "assets/images/profile5.jpg",
      "lastMessage": "New restaurant opened in Indiranagar!",
      "isActive": true,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xFF121212) : const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(isDark),
            _buildSearchBar(isDark),
            _buildTabBar(isDark),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildConversationsList(isDark),
                  _buildGroupsList(isDark),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 2),
    );
  }

  Widget _buildAppBar(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFE91E63),
              borderRadius: BorderRadius.circular(12),
            ),
            child:
                const Icon(Icons.chat_bubble, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Messages",
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
              Text(
                "${conversations.where((c) => c['unread'] > 0).length} unread",
                style: GoogleFonts.lato(
                  fontSize: 12,
                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                ),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[800] : Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.edit_square,
                  color: isDark ? Colors.white70 : Colors.black54),
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text("New message feature coming soon"),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(bool isDark) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.2 : 0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: isDark ? Colors.grey[400] : Colors.grey),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _isSearching = value.isNotEmpty;
                });
              },
              style: TextStyle(color: isDark ? Colors.white : Colors.black87),
              decoration: InputDecoration(
                hintText: "Search messages...",
                hintStyle: GoogleFonts.lato(color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
          ),
          if (_isSearching)
            IconButton(
              icon: Icon(Icons.close,
                  color: isDark ? Colors.grey[400] : Colors.grey),
              onPressed: () {
                setState(() {
                  _searchController.clear();
                  _isSearching = false;
                });
              },
            ),
        ],
      ),
    );
  }

  Widget _buildTabBar(bool isDark) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[800] : Colors.grey[200],
        borderRadius: BorderRadius.circular(16),
      ),
      child: TabBar(
        controller: _tabController,
        labelColor: Colors.white,
        unselectedLabelColor: isDark ? Colors.grey[400] : Colors.grey[600],
        indicator: BoxDecoration(
          color: const Color(0xFFE91E63),
          borderRadius: BorderRadius.circular(16),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelStyle:
            GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 13),
        unselectedLabelStyle: GoogleFonts.lato(fontSize: 13),
        tabs: [
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.chat_bubble_outline, size: 16),
                const SizedBox(width: 6),
                Text("Chats (${conversations.length})"),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.groups_outlined, size: 16),
                const SizedBox(width: 6),
                Text("Groups (${communityGroups.length})"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConversationsList(bool isDark) {
    final filteredConversations =
        _isSearching && _searchController.text.isNotEmpty
            ? conversations.where((conv) {
                final name = conv["name"]?.toString().toLowerCase() ?? "";
                final message =
                    conv["lastMessage"]?.toString().toLowerCase() ?? "";
                final query = _searchController.text.toLowerCase();
                return name.contains(query) || message.contains(query);
              }).toList()
            : conversations;

    if (filteredConversations.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off,
                size: 64, color: isDark ? Colors.grey[600] : Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              "No conversations found",
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: isDark ? Colors.grey[400] : Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredConversations.length,
      itemBuilder: (context, index) {
        return _buildConversationCard(filteredConversations[index], isDark);
      },
    );
  }


  Widget _buildConversationCard(Map<String, dynamic> conversation, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.2 : 0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ChatDetailScreen(conversation: conversation),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Stack(
                  children: [
                    Container(
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Image.asset(
                          conversation["image"],
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: isDark ? Colors.grey[800] : Colors.grey[300],
                              child: const Icon(Icons.person, color: Colors.grey),
                            );
                          },
                        ),
                      ),
                    ),
                    if (conversation["isOnline"])
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                            color: const Color(0xFF4CAF50),
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: isDark
                                    ? const Color(0xFF1E1E1E)
                                    : Colors.white,
                                width: 2),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              conversation["name"],
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white : Colors.black87,
                              ),
                            ),
                          ),
                          Text(
                            conversation["time"],
                            style: GoogleFonts.lato(
                              fontSize: 11,
                              color: conversation["unread"] > 0
                                  ? const Color(0xFFE91E63)
                                  : (isDark
                                      ? Colors.grey[400]
                                      : Colors.grey[500]),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Expanded(
                            child: conversation["isTyping"]
                                ? Row(
                                    children: [
                                      Text(
                                        "Typing",
                                        style: GoogleFonts.lato(
                                          fontSize: 13,
                                          color: const Color(0xFF4CAF50),
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      _buildTypingIndicator(),
                                    ],
                                  )
                                : Text(
                                    conversation["lastMessage"],
                                    style: GoogleFonts.lato(
                                      fontSize: 13,
                                      color: isDark
                                          ? Colors.grey[400]
                                          : Colors.grey[600],
                                      fontWeight: conversation["unread"] > 0
                                          ? FontWeight.w600
                                          : FontWeight.normal,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                          ),
                          if (conversation["unread"] > 0)
                            Container(
                              margin: const EdgeInsets.only(left: 8),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE91E63),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                "${conversation["unread"]}",
                                style: GoogleFonts.lato(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Row(
      children: List.generate(3, (index) {
        return Container(
          margin: const EdgeInsets.only(left: 2),
          width: 6,
          height: 6,
          decoration: const BoxDecoration(
            color: Color(0xFF4CAF50),
            shape: BoxShape.circle,
          ),
        );
      }),
    );
  }

  Widget _buildGroupsList(bool isDark) {
    final filteredGroups = _isSearching && _searchController.text.isNotEmpty
        ? communityGroups.where((group) {
            final name = group["name"]?.toString().toLowerCase() ?? "";
            final message =
                group["lastMessage"]?.toString().toLowerCase() ?? "";
            final query = _searchController.text.toLowerCase();
            return name.contains(query) || message.contains(query);
          }).toList()
        : communityGroups;

    if (filteredGroups.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off,
                size: 64, color: isDark ? Colors.grey[600] : Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              "No groups found",
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: isDark ? Colors.grey[400] : Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredGroups.length,
      itemBuilder: (context, index) {
        return _buildGroupCard(filteredGroups[index], isDark);
      },
    );
  }

  Widget _buildGroupCard(Map<String, dynamic> group, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.2 : 0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Opening ${group["name"]} group..."),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Container(
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE91E63),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child:
                      const Icon(Icons.groups, color: Colors.white, size: 30),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              group["name"],
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white : Colors.black87,
                              ),
                            ),
                          ),
                          if (group["isActive"])
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    const Color(0xFF4CAF50).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                "Active",
                                style: GoogleFonts.lato(
                                  fontSize: 10,
                                  color: const Color(0xFF4CAF50),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        group["lastMessage"],
                        style: GoogleFonts.lato(
                          fontSize: 12,
                          color: isDark ? Colors.grey[400] : Colors.grey[600],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.people,
                              size: 12,
                              color:
                                  isDark ? Colors.grey[400] : Colors.grey),
                          const SizedBox(width: 4),
                          Text(
                            "${group["members"]}+ members",
                            style: GoogleFonts.lato(
                              fontSize: 11,
                              color: isDark
                                  ? Colors.grey[400]
                                  : Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right,
                    color: isDark ? Colors.grey[400] : Colors.grey),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
