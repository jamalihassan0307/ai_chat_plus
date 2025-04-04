import 'package:flutter/material.dart';
import 'package:ai_chat_plus/ai_chat_plus.dart';
import 'package:ai_chat_plus/src/customizechat/widgets.dart';

class CustomChatPage extends StatefulWidget {
  const CustomChatPage({super.key});

  @override
  State<CustomChatPage> createState() => _CustomChatPageState();
}

class _CustomChatPageState extends State<CustomChatPage> {
  AIProvider _currentProvider = AIProvider.gemini;
  String? _modelId = GeminiModel.geminiFlash.modelId;

  final _customTheme = ChatTheme(
    primaryColor: Colors.purple,
    backgroundColor: const Color(0xFFF0F0F0),
    userBubbleColor: Colors.purple,
    aiBubbleColor: Colors.white,
    userTextColor: Colors.white,
    aiTextColor: Colors.black87,
    messageTextStyle: const TextStyle(
      fontSize: 16,
      fontFamily: 'Roboto',
      height: 1.5,
    ),
    timestampTextStyle: TextStyle(
      color: Colors.grey[600],
      fontSize: 12,
      fontFamily: 'Roboto',
    ),
    bubbleRadius: 20,
    bubblePadding: const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 12,
    ),
    avatarRadius: 24,
    inputDecoration: BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(30)),
      boxShadow: [
        BoxShadow(
          color: Colors.purple.withOpacity(0.1),
          blurRadius: 8,
          offset: const Offset(0, -2),
        ),
      ],
    ),
    inputTextColor: Colors.black87,
    inputBackgroundColor: Colors.grey[50]!,
    sendButtonTheme: const IconThemeData(
      color: Colors.purple,
      size: 28,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Theme Chat'),
        actions: [
          PopupMenuButton<AIProvider>(
            onSelected: _updateProvider,
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: AIProvider.openAI,
                child: Text('OpenAI'),
              ),
              const PopupMenuItem(
                value: AIProvider.gemini,
                child: Text('Gemini'),
              ),
              const PopupMenuItem(
                value: AIProvider.claude,
                child: Text('Claude'),
              ),
            ],
          ),
        ],
      ),
      body: CustomChatUI(
        messages: const [],
        onSendMessage: (message) {
          // Handle message sending
          print('Sending message: $message');
        },
        theme: _customTheme,
        userAvatarUrl: 'https://example.com/user-avatar.png',
        aiAvatarUrl: 'https://example.com/ai-avatar.png',
      ),
    );
  }

  void _updateProvider(AIProvider provider) {
    setState(() {
      _currentProvider = provider;
      switch (provider) {
        case AIProvider.gemini:
          _modelId = GeminiModel.geminiFlash.modelId;
          break;
        case AIProvider.openAI:
          _modelId = OpenAIModel.gpt35Turbo.modelId;
          break;
        case AIProvider.claude:
          _modelId = ClaudeModel.claude3Sonnet.modelId;
          break;
      }
    });
  }
} 