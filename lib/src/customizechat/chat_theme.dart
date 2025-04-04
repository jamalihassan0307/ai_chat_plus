import 'package:flutter/material.dart';

class ChatTheme {
  final Color primaryColor;
  final Color backgroundColor;
  final Color userBubbleColor;
  final Color aiBubbleColor;
  final Color userTextColor;
  final Color aiTextColor;
  final TextStyle messageTextStyle;
  final TextStyle timestampTextStyle;
  final double bubbleRadius;
  final EdgeInsets bubblePadding;
  final double avatarRadius;
  final BoxDecoration inputDecoration;
  final Color inputTextColor;
  final Color inputBackgroundColor;
  final IconThemeData sendButtonTheme;

  const ChatTheme({
    this.primaryColor = Colors.blue,
    this.backgroundColor = Colors.white,
    this.userBubbleColor = Colors.blue,
    this.aiBubbleColor = const Color(0xFFEEEEEE),
    this.userTextColor = Colors.white,
    this.aiTextColor = Colors.black87,
    this.messageTextStyle = const TextStyle(fontSize: 16),
    this.timestampTextStyle = const TextStyle(
      color: Colors.grey,
      fontSize: 12,
    ),
    this.bubbleRadius = 16,
    this.bubblePadding = const EdgeInsets.all(12),
    this.avatarRadius = 20,
    this.inputDecoration = const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(24)),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 4,
          offset: Offset(0, -2),
        ),
      ],
    ),
    this.inputTextColor = Colors.black87,
    this.inputBackgroundColor = const Color(0xFFF5F5F5),
    this.sendButtonTheme = const IconThemeData(
      color: Colors.blue,
      size: 24,
    ),
  });

  // Dark theme factory
  factory ChatTheme.dark() {
    return ChatTheme(
      primaryColor: Colors.blue,
      backgroundColor: const Color(0xFF1A1A1A),
      userBubbleColor: Colors.blue,
      aiBubbleColor: const Color(0xFF2D2D2D),
      userTextColor: Colors.white,
      aiTextColor: Colors.white,
      messageTextStyle: const TextStyle(
        fontSize: 16,
        color: Colors.white,
      ),
      timestampTextStyle: const TextStyle(
        color: Colors.grey,
        fontSize: 12,
      ),
      inputDecoration: const BoxDecoration(
        color: Color(0xFF2D2D2D),
        borderRadius: BorderRadius.all(Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(0, -2),
          ),
        ],
      ),
      inputTextColor: Colors.white,
      inputBackgroundColor: const Color(0xFF2D2D2D),
      sendButtonTheme: const IconThemeData(
        color: Colors.blue,
        size: 24,
      ),
    );
  }

  // Light theme factory
  factory ChatTheme.light() {
    return const ChatTheme();
  }

  // Custom theme with specific font
  factory ChatTheme.withFont({
    required String fontFamily,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return ChatTheme(
      messageTextStyle: TextStyle(
        fontSize: 16,
        fontFamily: fontFamily,
        fontWeight: fontWeight,
      ),
      timestampTextStyle: TextStyle(
        color: Colors.grey,
        fontSize: 12,
        fontFamily: fontFamily,
      ),
    );
  }
} 