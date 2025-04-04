import 'package:flutter/material.dart';
import 'package:ai_chat_plus/ai_chat_plus.dart';

void main() {
  runApp(const MyApp());
}

/// Example app demonstrating AI Chat Plus integration
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Chat Plus Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ChatDemo(),
    );
  }
}

/// Demonstrates basic usage of AI Chat Plus
class ChatDemo extends StatefulWidget {
  const ChatDemo({super.key});

  @override
  State<ChatDemo> createState() => _ChatDemoState();
}

class _ChatDemoState extends State<ChatDemo> {
  AIProvider _currentProvider = AIProvider.openAI;
  String? _modelId = OpenAIModel.gpt35Turbo.modelId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Chat Plus Demo'),
        actions: [
          PopupMenuButton<AIProvider>(
            initialValue: _currentProvider,
            onSelected: (AIProvider provider) {
              setState(() {
                _currentProvider = provider;
                _modelId = _getDefaultModel(provider);
              });
            },
            itemBuilder: (BuildContext context) => [
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
      body: AIChat(
        apiKey: _getApiKey(_currentProvider),
        provider: _currentProvider,
        modelId: _modelId,
      
      ),
    );
  }

  String _getApiKey(AIProvider provider) {
    switch (provider) {
      case AIProvider.openAI:
        return 'YOUR_OPENAI_API_KEY';
      case AIProvider.gemini:
        return 'YOUR_GEMINI_API_KEY';
      case AIProvider.claude:
        return 'YOUR_CLAUDE_API_KEY';
    }
  }

  String? _getDefaultModel(AIProvider provider) {
    switch (provider) {
      case AIProvider.openAI:
        return OpenAIModel.gpt35Turbo.modelId;
      case AIProvider.gemini:
        return GeminiModel.geminiFlash.modelId;
      case AIProvider.claude:
        return ClaudeModel.claude3Sonnet.modelId;
    }
  }
} 