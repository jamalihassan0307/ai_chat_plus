// ignore_for_file: unused_field, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:ai_chat_plus/ai_chat_plus.dart';
import 'package:ai_chat_plus/src/customizechat/widgets.dart';
import 'chat_settings_page.dart';

class CustomChatPage extends StatefulWidget {
  const CustomChatPage({super.key});

  @override
  State<CustomChatPage> createState() => _CustomChatPageState();
}

class _CustomChatPageState extends State<CustomChatPage> {
  AIProvider _currentProvider = AIProvider.gemini;
  String? _modelId = GeminiModel.geminiFlash.modelId;
  late ChatTheme _customTheme;
  late AIService _aiService;
  final List<ChatMessage> _messages = [];
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    _initializeTheme();
    _initializeService();
  }

  void _initializeTheme() {
    _customTheme = ChatTheme(
      primaryColor: Colors.purple,
      backgroundColor: const Color(0xFFF0F0F0),
      userBubbleGradient: const LinearGradient(
        colors: [Colors.purple, Colors.deepPurple],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
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
      inputDecoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(156, 39, 176, 0.1),
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      inputTextColor: Colors.black87,
      inputBackgroundColor: Colors.grey[50]!,
      sendButtonTheme: const IconThemeData(
        color: Colors.purple,
        size: 28,
      ),
      bubbleShadow: const BoxShadow(
        color: Color.fromRGBO(156, 39, 176, 0.1),
        blurRadius: 8,
        offset: Offset(0, 2),
      ),
    );
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

  void _openSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatSettingsPage(
          initialTheme: _customTheme,
          onThemeUpdated: (newTheme) {
            setState(() {
              _customTheme = newTheme;
            });
          },
        ),
      ),
    );
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
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: _openSettings,
          ),
        ],
      ),
      body: CustomChatUI(
        messages: _messages,
        onSendMessage: _handleSendMessage,
        isTyping: _isTyping,
        theme: _customTheme,
        userAvatarUrl: 'https://example.com/user-avatar.png',
        aiAvatarUrl: 'https://example.com/ai-avatar.png',
        enableAttachments: true,
        onAttachmentPressed: () {
          // Handle attachment
          // print('Attachment pressed');
        },
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
