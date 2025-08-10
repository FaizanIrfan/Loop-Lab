import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:loop_lab/Widgets/app_colors.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark;
    final textColor = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final secondaryTextColor = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
    final cardColor = isDark ? AppColors.darkCardBackground : Colors.white;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: isDark ? AppColors.darkCardBackground : Colors.white,
        elevation: 0,
        title: Text(
          'Messages',
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Search messages
            },
            icon: Icon(
              Icons.search,
              color: textColor,
            ),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primaryBlue,
          unselectedLabelColor: secondaryTextColor,
          indicatorColor: AppColors.primaryBlue,
          tabs: const [
            Tab(text: 'Direct'),
            Tab(text: 'Groups'),
            Tab(text: 'Support'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildDirectMessages(isDark, textColor, secondaryTextColor, cardColor),
          _buildGroupChats(isDark, textColor, secondaryTextColor, cardColor),
          _buildSupportChat(isDark, textColor, secondaryTextColor, cardColor),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showNewChatDialog(context, isDark);
        },
        backgroundColor: AppColors.primaryBlue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildDirectMessages(bool isDark, Color textColor, Color secondaryTextColor, Color cardColor) {
    final directMessages = [
      {
        'name': 'John Doe',
        'role': 'Instructor',
        'lastMessage': 'Great work on the assignment!',
        'time': '2m ago',
        'unread': 2,
        'online': true,
      },
      {
        'name': 'Jane Smith',
        'role': 'Student',
        'lastMessage': 'Can you help me with the project?',
        'time': '1h ago',
        'unread': 0,
        'online': false,
      },
      {
        'name': 'Admin',
        'role': 'Admin',
        'lastMessage': 'Welcome to LoopLab!',
        'time': '1d ago',
        'unread': 1,
        'online': true,
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: directMessages.length,
      itemBuilder: (context, index) {
        final chat = directMessages[index];
        return _buildChatItem(chat, isDark, textColor, secondaryTextColor, cardColor, () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatDetailScreen(
                chatName: chat['name'] as String,
                chatRole: chat['role'] as String,
              ),
            ),
          );
        });
      },
    );
  }

  Widget _buildGroupChats(bool isDark, Color textColor, Color secondaryTextColor, Color cardColor) {
    final groupChats = [
      {
        'name': 'Flutter Developers',
        'role': 'Group • 45 members',
        'lastMessage': 'Sarah: Check out this new package!',
        'time': '5m ago',
        'unread': 3,
        'online': true,
      },
      {
        'name': 'AI/ML Study Group',
        'role': 'Group • 28 members',
        'lastMessage': 'Mike: Meeting tomorrow at 3 PM',
        'time': '30m ago',
        'unread': 0,
        'online': false,
      },
      {
        'name': 'React Native Community',
        'role': 'Group • 67 members',
        'lastMessage': 'Lisa: New tutorial available',
        'time': '2h ago',
        'unread': 1,
        'online': true,
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: groupChats.length,
      itemBuilder: (context, index) {
        final chat = groupChats[index];
        return _buildChatItem(chat, isDark, textColor, secondaryTextColor, cardColor, () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatDetailScreen(
                chatName: chat['name'] as String,
                chatRole: chat['role'] as String,
                isGroup: true,
              ),
            ),
          );
        });
      },
    );
  }

  Widget _buildSupportChat(bool isDark, Color textColor, Color secondaryTextColor, Color cardColor) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.support_agent,
                  size: 60,
                  color: AppColors.primaryBlue,
                ),
                const SizedBox(height: 16),
                Text(
                  'AI Support Assistant',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Get instant help with your questions',
                  style: TextStyle(
                    fontSize: 16,
                    color: secondaryTextColor,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChatDetailScreen(
                            chatName: 'AI Support',
                            chatRole: 'Assistant',
                            isSupport: true,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'Start Chat',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          
          // FAQ Section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Frequently Asked Questions',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView(
                    children: [
                      _buildFAQItem('How do I enroll in a course?', isDark, textColor, secondaryTextColor, cardColor),
                      _buildFAQItem('How to join live sessions?', isDark, textColor, secondaryTextColor, cardColor),
                      _buildFAQItem('How to register for events?', isDark, textColor, secondaryTextColor, cardColor),
                      _buildFAQItem('How to reset my password?', isDark, textColor, secondaryTextColor, cardColor),
                      _buildFAQItem('How to contact instructors?', isDark, textColor, secondaryTextColor, cardColor),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatItem(Map<String, dynamic> chat, bool isDark, Color textColor, Color secondaryTextColor, Color cardColor, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Stack(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: AppColors.primaryBlue,
              child: Text(
                (chat['name'] as String)[0],
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            if (chat['online'] as bool)
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: AppColors.greenAccent,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isDark ? AppColors.darkCardBackground : Colors.white,
                      width: 2,
                    ),
                  ),
                ),
              ),
          ],
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                chat['name'] as String,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ),
            Text(
              chat['time'] as String,
              style: TextStyle(
                fontSize: 12,
                color: secondaryTextColor,
              ),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              chat['role'] as String,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.primaryBlue,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Expanded(
                  child: Text(
                    chat['lastMessage'] as String,
                    style: TextStyle(
                      color: secondaryTextColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if ((chat['unread'] as int) > 0)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: const BoxDecoration(
                      color: AppColors.primaryBlue,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${chat['unread']}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }

  Widget _buildFAQItem(String question, bool isDark, Color textColor, Color secondaryTextColor, Color cardColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        title: Text(
          question,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: secondaryTextColor,
        ),
        onTap: () {
          // Navigate to FAQ answer or start chat with this question
        },
      ),
    );
  }

  void _showNewChatDialog(BuildContext context, bool isDark) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isDark ? AppColors.darkCardBackground : Colors.white,
        title: Text(
          'Start New Chat',
          style: TextStyle(
            color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.person, color: AppColors.primaryBlue),
              title: Text(
                'Direct Message',
                style: TextStyle(
                  color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                // Show user selection
              },
            ),
            ListTile(
              leading: const Icon(Icons.group, color: AppColors.primaryBlue),
              title: Text(
                'Create Group',
                style: TextStyle(
                  color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                // Show group creation
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Chat Detail Screen
class ChatDetailScreen extends StatefulWidget {
  final String chatName;
  final String chatRole;
  final bool isGroup;
  final bool isSupport;
  
  const ChatDetailScreen({
    super.key,
    required this.chatName,
    required this.chatRole,
    this.isGroup = false,
    this.isSupport = false,
  });

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  
  final List<Map<String, dynamic>> _messages = [
    {
      'text': 'Hello! How can I help you today?',
      'isMe': false,
      'time': '10:30 AM',
      'sender': 'John Doe',
    },
    {
      'text': 'Hi! I have a question about the Flutter course.',
      'isMe': true,
      'time': '10:32 AM',
      'sender': 'You',
    },
    {
      'text': 'What would you like to know?',
      'isMe': false,
      'time': '10:33 AM',
      'sender': 'John Doe',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark;
    final textColor = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final secondaryTextColor = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
    final cardColor = isDark ? AppColors.darkCardBackground : Colors.white;
    final inputFillColor = isDark ? AppColors.darkBackground : Colors.grey[100];

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: isDark ? AppColors.darkCardBackground : Colors.white,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: AppColors.primaryBlue,
              child: Text(
                widget.chatName[0],
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.chatName,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.isSupport ? 'AI Assistant' : (widget.isGroup ? 'Group Chat' : 'Online'),
                    style: const TextStyle(
                      color: AppColors.greenAccent,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          if (!widget.isSupport) ...[
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.videocam,
                color: textColor,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.call,
                color: textColor,
              ),
            ),
          ],
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_vert,
              color: textColor,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Messages
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _buildMessageBubble(message, isDark, textColor, secondaryTextColor, cardColor);
              },
            ),
          ),
          
          // Message Input
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: cardColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.attach_file,
                    color: secondaryTextColor,
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      hintStyle: TextStyle(
                        color: secondaryTextColor,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: inputFillColor,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                    style: TextStyle(
                      color: textColor,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  decoration: const BoxDecoration(
                    color: AppColors.primaryBlue,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: _sendMessage,
                    icon: const Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(Map<String, dynamic> message, bool isDark, Color textColor, Color secondaryTextColor, Color cardColor) {
    final isMe = message['isMe'] as bool;
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isMe) ...[
            CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.primaryBlue,
              child: Text(
                widget.chatName[0],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isMe 
                    ? AppColors.primaryBlue
                    : cardColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message['text'] as String,
                    style: TextStyle(
                      color: isMe 
                          ? Colors.white
                          : textColor,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    message['time'] as String,
                    style: TextStyle(
                      color: isMe 
                          ? Colors.white.withOpacity(0.7)
                          : secondaryTextColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isMe) ...[
            const SizedBox(width: 8),
            CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.secondaryPurple, // Using secondary purple for user avatar
              child: const Text(
                'Y',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;
    
    setState(() {
      _messages.add({
        'text': _messageController.text.trim(),
        'isMe': true,
        'time': '${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}',
        'sender': 'You',
      });
    });
    
    _messageController.clear();
    
    // Scroll to bottom
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
    
    // Simulate response (for demo)
    if (widget.isSupport) {
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _messages.add({
            'text': 'I understand your question. Let me help you with that!',
            'isMe': false,
            'time': '${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}',
            'sender': 'AI Assistant',
          });
        });
      });
    }
  }
}
