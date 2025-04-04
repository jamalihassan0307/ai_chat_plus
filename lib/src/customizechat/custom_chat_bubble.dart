import 'package:flutter/material.dart';
import 'chat_theme.dart';

class CustomChatBubble extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser) _buildAvatar(),
          const SizedBox(width: 8),
          Flexible(
            child: Column(
              crossAxisAlignment:
                  isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: theme.bubblePadding,
                  decoration: BoxDecoration(
                    color: isUser
                        ? theme.userBubbleColor
                        : theme.aiBubbleColor,
                    borderRadius: BorderRadius.circular(theme.bubbleRadius),
                  ),
                  child: Text(
                    message,
                    style: theme.messageTextStyle.copyWith(
                      color: isUser
                          ? theme.userTextColor
                          : theme.aiTextColor,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    _formatTime(timestamp),
                    style: theme.timestampTextStyle,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          if (isUser) _buildAvatar(),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return CircleAvatar(
      radius: theme.avatarRadius,
      backgroundColor: isUser
          ? theme.userBubbleColor.withOpacity(0.3)
          : theme.aiBubbleColor,
      backgroundImage: avatarUrl != null ? NetworkImage(avatarUrl!) : null,
      child: avatarUrl == null
          ? Icon(
              isUser ? Icons.person : Icons.smart_toy,
              color: isUser ? theme.userTextColor : theme.aiTextColor,
              size: theme.avatarRadius * 1.2,
            )
          : null,
    );
  }

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
} 