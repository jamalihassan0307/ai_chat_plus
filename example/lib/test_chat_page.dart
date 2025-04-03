import 'package:flutter/material.dart';
import 'package:ai_chat_plus/ai_chat_plus.dart';

class TestChatPage extends StatefulWidget {
  const TestChatPage({Key? key}) : super(key: key);

  @override
  State<TestChatPage> createState() => _TestChatPageState();
}

class _TestChatPageState extends State<TestChatPage> {
  AIProvider _currentProvider = AIProvider.gemini;
  String? _modelId;

  void _updateProvider(AIProvider provider) {
    setState(() {
      _currentProvider = provider;
      // Set default model ID based on provider
      switch (provider) {
        case AIProvider.gemini:
          _modelId = GeminiModel.geminiFlash.modelId; break;
        case AIProvider.openAI:
          _modelId = OpenAIModel.gpt35Turbo.modelId;
         
          break;
        case AIProvider.claude:
          _modelId = ClaudeModel.claude3Sonnet.modelId;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Chat Plus Demo'),
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
      body: AIChat(
        apiKey: _getApiKey(),
        provider: _currentProvider,
        modelId: _modelId,
        primaryColor: Theme.of(context).primaryColor,
        backgroundColor: Colors.grey[100],
        inputDecoration: InputDecoration(
          hintText: 'Ask me anything...',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
        ),
        messageTextStyle: const TextStyle(
          fontSize: 16,
          height: 1.5,
        ),
      ),
    );
  }

  String _getApiKey() {
    // Replace these with your actual API keys
    switch (_currentProvider) {
      case AIProvider.openAI:
        return 'YOUR_OPENAI_API_KEY';
      case AIProvider.gemini:
        return 'YOUR_OPENAI_API_KEY';
      case AIProvider.claude:
        return 'YOUR_CLAUDE_API_KEY';
    }
  }
} 