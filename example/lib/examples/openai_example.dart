import 'package:ai_chat_plus/ai_chat_plus.dart';
import 'package:flutter/material.dart';

class OpenAIChatScreen extends StatefulWidget {
  const OpenAIChatScreen({super.key});

  @override
  State<OpenAIChatScreen> createState() => _OpenAIChatScreenState();
}

class _OpenAIChatScreenState extends State<OpenAIChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _messages = [];
  late final AIService _aiService;
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _initOpenAI();
  }

  Future<void> _initOpenAI() async {
    try {
      final config = AIModelConfig(
        provider: AIProvider.openAI,
        apiKey: 'YOUR_OPENAI_API_KEY',  // Replace with your OpenAI API key
        modelId: OpenAIModel.gpt35Turbo.modelId,
      );

      _aiService = AIServiceFactory.createService(AIProvider.openAI);
      await _aiService.initialize(config);
      setState(() => _error = null);
    } catch (e) {
      setState(() => _error = e.toString());
    }
  }

  Future<void> _sendMessage() async {
    if (_controller.text.isEmpty) return;

    final message = _controller.text;
    setState(() {
      _messages.add('You: $message');
      _isLoading = true;
      _error = null;
    });
    _controller.clear();

    try {
      final response = await _aiService.generateResponse(message);
      setState(() {
        _messages.add('OpenAI: $response');
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _aiService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OpenAI Chat Example'),
      ),
      body: Column(
        children: [
          if (_error != null)
            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.red.shade100,
              child: Text(
                'Error: $_error',
                style: const TextStyle(color: Colors.red),
              ),
            ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUser = message.startsWith('You: ');
                
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.blue.shade100 : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(message),
                  ),
                );
              },
            ),
          ),
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Ask OpenAI something...',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: _sendMessage,
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 