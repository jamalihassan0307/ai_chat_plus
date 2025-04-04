import 'package:flutter/material.dart';
import 'chat_theme.dart';

class CustomChatBubble extends StatefulWidget {
  final String message;
  final bool isUser;
  final String? avatarUrl;
  final DateTime timestamp;
  final ChatTheme theme;

  const CustomChatBubble({
    super.key,
    required this.message,
    required this.isUser,
    this.avatarUrl,
    required this.timestamp,
    required this.theme,
  });

  @override
  State<CustomChatBubble> createState() => _CustomChatBubbleState();
}

class _CustomChatBubbleState extends State<CustomChatBubble>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        mainAxisAlignment:
            widget.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!widget.isUser) _buildAvatar(),
          const SizedBox(width: 8),
          Flexible(
            child: Column(
              crossAxisAlignment: widget.isUser
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: widget.theme.bubbleMaxWidth,
                      ),
                      padding: widget.theme.bubblePadding,
                      decoration: BoxDecoration(
                        gradient: widget.isUser
                            ? widget.theme.userBubbleGradient
                            : widget.theme.aiBubbleGradient,
                        color: widget.isUser
                            ? widget.theme.userBubbleColor
                            : widget.theme.aiBubbleColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(widget.theme.bubbleRadius),
                          topRight: Radius.circular(widget.theme.bubbleRadius),
                          bottomLeft: Radius.circular(
                              widget.isUser ? widget.theme.bubbleRadius : 4),
                          bottomRight: Radius.circular(
                              widget.isUser ? 4 : widget.theme.bubbleRadius),
                        ),
                        boxShadow: widget.theme.bubbleShadow != null
                            ? [widget.theme.bubbleShadow!]
                            : null,
                      ),
                      child: Text(
                        widget.message,
                        style: widget.theme.messageTextStyle.copyWith(
                          color: widget.isUser
                              ? widget.theme.userTextColor
                              : widget.theme.aiTextColor,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    _formatTime(widget.timestamp),
                    style: widget.theme.timestampTextStyle,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          if (widget.isUser) _buildAvatar(),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(26),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: CircleAvatar(
        radius: widget.theme.avatarRadius,
        backgroundColor: widget.isUser
            ? widget.theme.userBubbleColor.withAlpha(51)
            : widget.theme.aiBubbleColor,
        backgroundImage:
            widget.avatarUrl != null ? NetworkImage(widget.avatarUrl!) : null,
        child: widget.avatarUrl == null
            ? Icon(
                widget.isUser ? Icons.person : Icons.smart_toy,
                color: widget.isUser
                    ? widget.theme.userTextColor
                    : widget.theme.aiTextColor,
                size: widget.theme.avatarRadius * 1.2,
              )
            : null,
      ),
    );
  }

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}
