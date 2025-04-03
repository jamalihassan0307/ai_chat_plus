import 'package:flutter/material.dart';
import 'chat_bubble.dart';
import 'typing_indicator.dart';

class ChatMessage {
  final String message;
  final bool isUser;
  final String? avatarUrl;
  final DateTime timestamp;

  ChatMessage({
    required this.message,
    required this.isUser,
    this.avatarUrl,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();
}

class ChatUI extends StatefulWidget {
  final List<ChatMessage> messages;
  final Function(String) onSendMessage;
  final bool isTyping;
  final Color? primaryColor;
  final Color? backgroundColor;
  final String? userAvatarUrl;
  final String? aiAvatarUrl;
  final InputDecoration? inputDecoration;
  final TextStyle? messageTextStyle;

  const ChatUI({
    super.key,
    required this.messages,
    required this.onSendMessage,
    this.isTyping = false,
    this.primaryColor,
    this.backgroundColor,
    this.userAvatarUrl,
    this.aiAvatarUrl,
    this.inputDecoration,
    this.messageTextStyle,
  });

  @override
  State<ChatUI> createState() => _ChatUIState();
}

class _ChatUIState extends State<ChatUI> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _textController.dispose();
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

  @override
  void didUpdateWidget(ChatUI oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.messages.length > oldWidget.messages.length) {
      _scrollToBottom();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor ?? Colors.white,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(8),
              itemCount: widget.messages.length + (widget.isTyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == widget.messages.length) {
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: TypingIndicator(
                      dotColor: widget.primaryColor ?? Theme.of(context).primaryColor,
                    ),
                  );
                }

                final message = widget.messages[index];
                return ChatBubble(
                  message: message.message,
                  isUser: message.isUser,
                  avatarUrl: message.isUser ? widget.userAvatarUrl : widget.aiAvatarUrl,
                  timestamp: message.timestamp,
                );
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, -2),
                  blurRadius: 4,
                  color: Colors.black.withOpacity(0.1),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      decoration: widget.inputDecoration ??
                          InputDecoration(
                            hintText: 'Type a message...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.grey[100],
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                          ),
                      onSubmitted: _handleSubmitted,
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.send),
                    color: widget.primaryColor ?? Theme.of(context).primaryColor,
                    onPressed: () => _handleSubmitted(_textController.text),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleSubmitted(String text) {
    if (text.trim().isEmpty) return;
    widget.onSendMessage(text);
    _textController.clear();
  }
} 