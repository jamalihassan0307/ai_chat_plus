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
  final Gradient? userBubbleGradient;
  final Gradient? aiBubbleGradient;
  final BoxShadow? bubbleShadow;
  final double bubbleMaxWidth;
  final Animation<double>? bubbleAnimation;

  const ChatTheme({
    this.primaryColor = Colors.blue,
    this.backgroundColor = Colors.white,
    this.userBubbleColor = Colors.blue,
    this.aiBubbleColor = const Color(0xFFF0F0F0),
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
      border: Border(top: BorderSide(color: Colors.grey)),
    ),
    this.inputTextColor = Colors.black87,
    this.inputBackgroundColor = Colors.white,
    this.sendButtonTheme = const IconThemeData(color: Colors.blue),
    this.userBubbleGradient,
    this.aiBubbleGradient,
    this.bubbleShadow,
    this.bubbleMaxWidth = 280,
    this.bubbleAnimation,
  });

  // Dark theme factory
  factory ChatTheme.dark() {
    return  ChatTheme(
      primaryColor: Colors.blue,
      backgroundColor: const Color(0xFF1A1A1A),
      userBubbleGradient: const LinearGradient(
        colors: [Color(0xFF2196F3), Color(0xFF1976D2)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      aiBubbleColor: const Color(0xFF2D2D2D),
      userTextColor: Colors.white,
      aiTextColor: Colors.white,
      messageTextStyle: const TextStyle(
        fontSize: 16,
        height: 1.4,
        fontWeight: FontWeight.w400,
      ),
      timestampTextStyle: const TextStyle(
        color: Colors.grey,
        fontSize: 12,
      ),
      bubbleShadow: BoxShadow(
        color: Colors.black.withAlpha(51), // 0.2 * 255 ≈ 51
        blurRadius: 8,
        offset: const Offset(0, 2),
      ),
      inputDecoration: const BoxDecoration(
        color: Color(0xFF2D2D2D),
      ),
      inputTextColor: Colors.white,
      inputBackgroundColor: const Color(0xFF3D3D3D),
      sendButtonTheme: const IconThemeData(color: Colors.blue),
    );
  }

  // Light theme factory
  factory ChatTheme.light() {
    return ChatTheme(
      primaryColor: Colors.blue,
      backgroundColor: Colors.grey[50]!,
      userBubbleGradient: const LinearGradient(
        colors: [Color(0xFF2196F3), Color(0xFF1976D2)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      aiBubbleColor: Colors.white,
      userTextColor: Colors.white,
      aiTextColor: Colors.black87,
      messageTextStyle: const TextStyle(
        fontSize: 16,
        height: 1.4,
        fontWeight: FontWeight.w400,
      ),
      bubbleShadow:  BoxShadow(
        color: Colors.black.withAlpha(51), // 0.05 * 255 ≈ 13
        blurRadius: 8,
        offset: const Offset(0, 2),
      ),
      inputDecoration:  BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(51), // 0.05 * 255 ≈ 13
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
    );
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

  ChatTheme copyWith({
    Color? primaryColor,
    Color? backgroundColor,
    Color? userBubbleColor,
    Color? aiBubbleColor,
    Color? userTextColor,
    Color? aiTextColor,
    TextStyle? messageTextStyle,
    TextStyle? timestampTextStyle,
    double? bubbleRadius,
    EdgeInsets? bubblePadding,
    double? avatarRadius,
    BoxDecoration? inputDecoration,
    Color? inputTextColor,
    Color? inputBackgroundColor,
    IconThemeData? sendButtonTheme,
    Gradient? userBubbleGradient,
    Gradient? aiBubbleGradient,
    BoxShadow? bubbleShadow,
    double? bubbleMaxWidth,
    Animation<double>? bubbleAnimation,
  }) {
    return ChatTheme(
      primaryColor: primaryColor ?? this.primaryColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      userBubbleColor: userBubbleColor ?? this.userBubbleColor,
      aiBubbleColor: aiBubbleColor ?? this.aiBubbleColor,
      userTextColor: userTextColor ?? this.userTextColor,
      aiTextColor: aiTextColor ?? this.aiTextColor,
      messageTextStyle: messageTextStyle ?? this.messageTextStyle,
      timestampTextStyle: timestampTextStyle ?? this.timestampTextStyle,
      bubbleRadius: bubbleRadius ?? this.bubbleRadius,
      bubblePadding: bubblePadding ?? this.bubblePadding,
      avatarRadius: avatarRadius ?? this.avatarRadius,
      inputDecoration: inputDecoration ?? this.inputDecoration,
      inputTextColor: inputTextColor ?? this.inputTextColor,
      inputBackgroundColor: inputBackgroundColor ?? this.inputBackgroundColor,
      sendButtonTheme: sendButtonTheme ?? this.sendButtonTheme,
      userBubbleGradient: userBubbleGradient ?? this.userBubbleGradient,
      aiBubbleGradient: aiBubbleGradient ?? this.aiBubbleGradient,
      bubbleShadow: bubbleShadow ?? this.bubbleShadow,
      bubbleMaxWidth: bubbleMaxWidth ?? this.bubbleMaxWidth,
      bubbleAnimation: bubbleAnimation ?? this.bubbleAnimation,
    );
  }
}
