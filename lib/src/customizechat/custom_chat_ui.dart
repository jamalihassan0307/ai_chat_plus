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
  final VoidCallback? onAttachmentPressed;
  final bool enableAttachments;
  final String hintText;

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
    this.onAttachmentPressed,
    this.enableAttachments = false,
    this.hintText = 'Type a message...',
  });

  @override
  State<CustomChatUI> createState() => _CustomChatUIState();
}

class _CustomChatUIState extends State<CustomChatUI>
    with SingleTickerProviderStateMixin {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late AnimationController _sendButtonController;
  late Animation<double> _sendButtonAnimation;

  bool get _canSendMessage => _textController.text.trim().isNotEmpty;

  @override
  void initState() {
    super.initState();
    _sendButtonController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _sendButtonAnimation = CurvedAnimation(
      parent: _sendButtonController,
      curve: Curves.easeIn,
    );

    _textController.addListener(() {
      if (_canSendMessage) {
        _sendButtonController.forward();
      } else {
        _sendButtonController.reverse();
      }
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    _sendButtonController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (!_scrollController.hasClients) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
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
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
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
      child: SafeArea(
        child: Row(
          children: [
            if (widget.enableAttachments)
              IconButton(
                icon: const Icon(Icons.attach_file),
                color: widget.theme.sendButtonTheme.color,
                onPressed: widget.onAttachmentPressed,
              ),
            Expanded(
              child: TextField(
                controller: _textController,
                style: TextStyle(color: widget.theme.inputTextColor),
                maxLines: 5,
                minLines: 1,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  hintStyle: TextStyle(
                    color: Color.fromRGBO(
                        widget.theme.inputTextColor.red,
                        widget.theme.inputTextColor.green,
                        widget.theme.inputTextColor.blue,
                        0.6),
                  ),
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
            ScaleTransition(
              scale: _sendButtonAnimation,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _canSendMessage
                      ? widget.theme.primaryColor
                      : Color.fromRGBO(
                          widget.theme.primaryColor.red,
                          widget.theme.primaryColor.green,
                          widget.theme.primaryColor.blue,
                          0.5),
                ),
                child: IconButton(
                  icon: const Icon(Icons.send),
                  color: Colors.white,
                  iconSize: widget.theme.sendButtonTheme.size ?? 24,
                  onPressed: _canSendMessage
                      ? () => _handleSubmitted(_textController.text)
                      : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleSubmitted(String text) {
    final trimmedText = text.trim();
    if (trimmedText.isEmpty) return;
    widget.onSendMessage(trimmedText);
    _textController.clear();
  }
}
