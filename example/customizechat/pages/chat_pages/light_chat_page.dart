import 'package:flutter/material.dart';
import 'package:ai_chat_plus/ai_chat_plus.dart';
import 'package:ai_chat_plus/src/customizechat/widgets.dart';

class LightChatPage extends StatefulWidget {
  const LightChatPage({super.key});

  @override
  State<LightChatPage> createState() => _LightChatPageState();
}

class _LightChatPageState extends State<LightChatPage> {
  AIProvider _currentProvider = AIProvider.gemini;
  String? _modelId = GeminiModel.geminiFlash.modelId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Light Theme Chat'),
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
        theme: ChatTheme.light(),
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