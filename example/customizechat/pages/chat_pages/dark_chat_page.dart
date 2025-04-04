// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:ai_chat_plus/ai_chat_plus.dart';
import 'package:ai_chat_plus/src/customizechat/widgets.dart';

class DarkChatPage extends StatefulWidget {
  const DarkChatPage({super.key});

  @override
  State<DarkChatPage> createState() => _DarkChatPageState();
}

class _DarkChatPageState extends State<DarkChatPage> {
  AIProvider _currentProvider = AIProvider.gemini;
  String? _modelId = GeminiModel.geminiFlash.modelId;
  late AIService _aiService;
  final List<ChatMessage> _messages = [];
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    _initializeService();
  }

  Future<void> _initializeService() async {
    _aiService = AIServiceFactory.createService(_currentProvider);
    await _aiService.initialize(
      AIModelConfig(
        provider: _currentProvider,
        apiKey: _getApiKey(),
        modelId: _modelId,
      ),
    );
  }

  String _getApiKey() {
    switch (_currentProvider) {
      case AIProvider.openAI:
        return 'your-openai-api-key';
      case AIProvider.gemini:
        return 'your-gemini-api-key';
      case AIProvider.claude:
        return 'your-claude-api-key';
    }
  }

  Future<void> _handleSendMessage(String message) async {
    setState(() {
      _messages.add(ChatMessage(
        message: message,
        isUser: true,
        timestamp: DateTime.now(),
      ));
      _isTyping = true;
    });

    try {
      final response = await _aiService.generateResponse(message);
      setState(() {
        _messages.add(ChatMessage(
          message: response,
          isUser: false,
          timestamp: DateTime.now(),
        ));
        _isTyping = false;
      });
    } catch (e) {
      setState(() {
        _isTyping = false;
        _messages.add(ChatMessage(
          message: "Error: Unable to generate response. Please try again.",
          isUser: false,
          timestamp: DateTime.now(),
        ));
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    _aiService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dark Theme Chat'),
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
        messages: _messages,
        onSendMessage: _handleSendMessage,
        isTyping: _isTyping,
        theme: ChatTheme.dark(),
        userAvatarUrl: 'https://example.com/user-avatar.png',
        aiAvatarUrl: 'https://example.com/ai-avatar.png',
      ),
    );
  }

  Future<void> _updateProvider(AIProvider provider) async {
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
    await _initializeService();
  }
} 