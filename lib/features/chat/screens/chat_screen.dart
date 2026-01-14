import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/text_styles.dart';
import '../services/gemini_service.dart';
import '../widgets/crisis_overlay.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final GeminiService _geminiService = GeminiService();
  bool _isTyping = false;

  final List<Map<String, dynamic>> _messages = [
    {
      'sender': 'ai',
      'message': 'Hi there! 👋 I\'m LIRAZA. I\'m here to listen without judgment. How are you feeling right now?',
      'time': 'Just now',
    },
  ];

  final List<String> _quickReplies = [
    "I'm feeling anxious 😰",
    "I had a tough day 😔",
    "Just want to chat 💬",
    "I'm feeling happy! 😊",
  ];

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _sendMessage({String? text}) async {
    final messageText = text ?? _messageController.text.trim();
    if (messageText.isEmpty) return;

    _messageController.clear();

    setState(() {
      _messages.add({
        'sender': 'user',
        'message': messageText,
        'time': _formatTime(),
      });
      _isTyping = true;
    });
    _scrollToBottom();

    try {
      final responseMap = await _geminiService.sendMessage(messageText);
      final responseText = responseMap['text'];
      final isCrisis = responseMap['isCrisis'] == true;

      if (mounted) {
        setState(() {
          _isTyping = false;
          _messages.add({
            'sender': 'ai',
            'message': responseText,
            'time': _formatTime(),
          });
        });
        _scrollToBottom();

        if (isCrisis) {
          _showCrisisOverlay();
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isTyping = false;
          _messages.add({
            'sender': 'ai',
            'message': 'Sorry, I encountered an error. Please try again.',
            'time': _formatTime(),
          });
        });
        _scrollToBottom();
      }
    }
  }

  String _formatTime() {
    final now = TimeOfDay.now();
    final context = this.context;
    return now.format(context);
  }

  void _showCrisisOverlay() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          body: CrisisOverlay(
            onDismiss: () => Navigator.of(context).pop(),
          ),
        ),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softWhite,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.primaryGradient,
          ),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(2),
               decoration: const BoxDecoration(
                 color: Colors.white,
                 shape: BoxShape.circle,
               ),
              child: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.auto_awesome, color: AppColors.hotPink),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'LIRAZA AI', 
                  style: AppTextStyles.h4.copyWith(color: Colors.white, fontSize: 16),
                ),
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Color(0xFF4CAF50), // Online green
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Always here for you',
                      style: AppTextStyles.caption.copyWith(color: Colors.white.withOpacity(0.9)),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              children: [
                Text('😊', style: TextStyle(fontSize: 16)),
                SizedBox(width: 4),
                Text('7/10', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Ambient Background Blobs
          Positioned(
            top: 50,
            left: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: AppColors.softPink.withOpacity(0.1),
                shape: BoxShape.circle,
                // filter: null, // Removed invalid parameter
              ),
            ),
          ),
           Positioned(
            bottom: 100,
            right: -30,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: AppColors.blushPink.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
            ),
          ),

          Column(
            children: [
              // Chat List
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: _messages.length + (_isTyping ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == _messages.length && _isTyping) {
                      return const Align(
                        alignment: Alignment.centerLeft,
                        child: _TypingIndicator(),
                      );
                    }
                    
                    final message = _messages[index];
                    final isUser = message['sender'] == 'user';
                    return _MessageBubble(
                      message: message['message'],
                      time: message['time'],
                      isUser: isUser,
                    );
                  },
                ),
              ),

              // Quick Replies
              if (!_isTyping && _messages.length < 3)
                SizedBox(
                  height: 50,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _quickReplies.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      return ActionChip(
                        label: Text(_quickReplies[index]),
                        backgroundColor: Colors.white,
                        surfaceTintColor: Colors.white,
                        labelStyle: TextStyle(
                          color: AppColors.hotPink,
                          fontWeight: FontWeight.w500,
                        ),
                        side: const BorderSide(color: AppColors.hotPink),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        onPressed: () => _sendMessage(text: _quickReplies[index]),
                      );
                    },
                  ),
                ),

              const SizedBox(height: 8),

              // Input Area (Redesigned)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                color: AppColors.softPink.withOpacity(0.3), // Light pink background
                child: Row(
                  children: [
                    // Mood/Emoji Button
                    Container(
                      decoration: const BoxDecoration(
                        color: AppColors.hotPink,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.sentiment_satisfied_alt_outlined, color: Colors.white),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(minWidth: 44, minHeight: 44),
                      ),
                    ),
                    const SizedBox(width: 8),
                    
                    // Voice Button
                    Container(
                      decoration: const BoxDecoration(
                        color: AppColors.hotPink,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.mic_none_outlined, color: Colors.white),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(minWidth: 44, minHeight: 44),
                      ),
                    ),
                    const SizedBox(width: 12),

                    // Text Input
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: AppColors.softPink, width: 2),
                        ),
                        child: TextField(
                          controller: _messageController,
                          decoration: InputDecoration(
                            hintText: 'You can write or say whatever feels heavy...',
                            hintStyle: TextStyle(color: AppColors.hotPink.withOpacity(0.5)),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          ),
                          style: const TextStyle(color: AppColors.textPrimary),
                          minLines: 1,
                          maxLines: 4,
                          textCapitalization: TextCapitalization.sentences,
                          onSubmitted: (_) => _sendMessage(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    
                    // Send Button
                    GestureDetector(
                      onTap: () => _sendMessage(),
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: const BoxDecoration(
                          color: AppColors.hotPink,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.send_rounded, color: Colors.white, size: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final String message;
  final String time;
  final bool isUser;

  const _MessageBubble({
    required this.message,
    required this.time,
    required this.isUser,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        decoration: BoxDecoration(
          color: isUser ? null : Colors.white,
          gradient: isUser ? AppColors.primaryGradient : null,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: isUser ? const Radius.circular(20) : const Radius.circular(0),
            bottomRight: isUser ? const Radius.circular(0) : const Radius.circular(20),
          ),
          boxShadow: isUser ? [
            BoxShadow(
              color: AppColors.hotPink.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            )
          ] : [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: isUser ? Colors.white : AppColors.textPrimary,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 4),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  time,
                  style: AppTextStyles.caption.copyWith(
                    color: isUser ? Colors.white.withOpacity(0.7) : AppColors.textHint,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TypingIndicator extends StatelessWidget {
  const _TypingIndicator();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16, left: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildDot(0),
          const SizedBox(width: 4),
          _buildDot(200),
          const SizedBox(width: 4),
          _buildDot(400),
        ],
      ),
    );
  }

  Widget _buildDot(int delay) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
         return Opacity(
           opacity: (value < 0.5) ? value * 2 : (1.0 - value) * 2,
           child: Container(
             width: 8,
             height: 8,
             decoration: const BoxDecoration(
               color: AppColors.softPink,
               shape: BoxShape.circle,
             ),
           ),
         );
      },
      onEnd: () {},
    );
  }
}
