import 'package:flutter/material.dart';
import 'chat_theme.dart';
import 'custom_chat_bubble.dart';
import 'custom_typing_indicator.dart';
import '../widgets/chat_ui.dart' show ChatMessage;

class CustomChatUI extends StatefulWidget {
  final List<ChatMessage> messages;
  final Function(String) onSendMessage;
  final bool isTyping;
  final ChatTheme theme;
  final String? userAvatarUrl;
  final String? aiAvatarUrl;
  final Widget? Function(BuildContext, ChatMessage)? bubbleBuilder;
  final Widget? Function(BuildContext)? inputBuilder;
  final Widget? Function(BuildContext)? typingIndicatorBuilder;

  const CustomChatUI({
    super.key,
    required this.messages,
    required this.onSendMessage,
    this.isTyping = false,
    this.theme = const ChatTheme(),
    this.userAvatarUrl,
    this.aiAvatarUrl,
    this.bubbleBuilder,
    this.inputBuilder,
    this.typingIndicatorBuilder,
  });

  @override
  State<CustomChatUI> createState() => _CustomChatUIState();
}

class _CustomChatUIState extends State<CustomChatUI> {
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
  void didUpdateWidget(CustomChatUI oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.messages.length > oldWidget.messages.length) {
      _scrollToBottom();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.theme.backgroundColor,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(8),
              itemCount: widget.messages.length + (widget.isTyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == widget.messages.length) {
                  return widget.typingIndicatorBuilder?.call(context) ??
                      CustomTypingIndicator(theme: widget.theme);
                }

                final message = widget.messages[index];
                return widget.bubbleBuilder?.call(context, message) ??
                    CustomChatBubble(
                      message: message.message,
                      isUser: message.isUser,
                      avatarUrl: message.isUser
                          ? widget.userAvatarUrl
                          : widget.aiAvatarUrl,
                      timestamp: message.timestamp,
                      theme: widget.theme,
                    );
              },
            ),
          ),
          widget.inputBuilder?.call(context) ?? _buildInput(),
        ],
      ),
    );
  }

  Widget _buildInput() {
    return Container(
      decoration: widget.theme.inputDecoration,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              style: TextStyle(color: widget.theme.inputTextColor),
              decoration: InputDecoration(
                hintText: 'Type a message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: widget.theme.inputBackgroundColor,
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
            color: widget.theme.sendButtonTheme.color,
            iconSize: widget.theme.sendButtonTheme.size ?? 24,
            onPressed: () => _handleSubmitted(_textController.text),
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