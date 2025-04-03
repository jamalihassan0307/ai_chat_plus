library ai_chat_plus;

export 'src/models/ai_model.dart';
export 'src/services/ai_service.dart';
export 'src/services/openai_service.dart';
export 'src/services/gemini_service.dart';
export 'src/widgets/widgets.dart';

import 'package:flutter/material.dart';
import 'src/models/ai_model.dart';
import 'src/services/ai_service.dart';
import 'src/widgets/widgets.dart';

/// Main widget for AI Chat Plus
class AIChat extends StatefulWidget {
  final String apiKey;
  final AIProvider provider;
  final String? modelId;
  final Color? primaryColor;
  final Color? backgroundColor;
  final String? userAvatarUrl;
  final String? aiAvatarUrl;
  final InputDecoration? inputDecoration;
  final TextStyle? messageTextStyle;

  const AIChat({
    Key? key,
    required this.apiKey,
    required this.provider,
    this.modelId,
    this.primaryColor,
    this.backgroundColor,
    this.userAvatarUrl,
    this.aiAvatarUrl,
    this.inputDecoration,
    this.messageTextStyle,
  }) : super(key: key);

  @override
  State<AIChat> createState() => _AIChatState();
}

class _AIChatState extends State<AIChat> {
  late AIService _aiService;
  final List<ChatMessage> _messages = [];
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    _initializeService();
  }

  Future<void> _initializeService() async {
    _aiService = AIServiceFactory.createService(widget.provider);
    await _aiService.initialize(
      AIModelConfig(
        provider: widget.provider,
        apiKey: widget.apiKey,
        modelId: widget.modelId,
      ),
    );
  }

  Future<void> _handleSendMessage(String message) async {
    setState(() {
      _messages.add(ChatMessage(
        message: message,
        isUser: true,
      ));
      _isTyping = true;
    });

    try {
      final response = await _aiService.generateResponse(message);
      setState(() {
        _messages.add(ChatMessage(
          message: response,
          isUser: false,
        ));
        _isTyping = false;
      });
    } catch (e) {
      setState(() {
        _isTyping = false;
        _messages.add(ChatMessage(
          message: "Error: Unable to generate response. Please try again.",
          isUser: false,
        ));
      });
    }
  }

  @override
  void dispose() {
    _aiService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChatUI(
      messages: _messages,
      onSendMessage: _handleSendMessage,
      isTyping: _isTyping,
      primaryColor: widget.primaryColor,
      backgroundColor: widget.backgroundColor,
      userAvatarUrl: widget.userAvatarUrl,
      aiAvatarUrl: widget.aiAvatarUrl,
      inputDecoration: widget.inputDecoration,
      messageTextStyle: widget.messageTextStyle,
    );
  }
}
