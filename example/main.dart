import 'package:flutter/material.dart';
import 'package:ai_chat_plus/ai_chat_plus.dart';

void main() {
  runApp(const MyApp());
}

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
      home: const ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _messages = [];
  late final AIChat _aiChat;
  bool _isLoading = false;
  String? _error;
  AIProvider _currentProvider = AIProvider.gemini;

  @override
  void initState() {
    super.initState();
    _initAI();
  }

  void _initAI() {
    _aiChat = AIChat(
      apiKey: _currentProvider == AIProvider.openAI
          ? 'YOUR_OPENAI_API_KEY'
          : 'YOUR_GEMINI_API_KEY',
          assistantModel: 'gpt-3.5-turbo',  
    );
  }

  void _switchProvider() {
    setState(() {
      _currentProvider = _currentProvider == AIProvider.openAI
          ? AIProvider.gemini
          : AIProvider.openAI;
      _initAI();
    });
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
      final response = await _aiChat.generateResponse(message);
      setState(() {
        _messages.add('${_currentProvider == AIProvider.openAI ? "OpenAI" : "Gemini"}: $response');
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
    _aiChat.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${_currentProvider == AIProvider.openAI ? "OpenAI" : "Gemini"} Chat'),
        actions: [
          IconButton(
            icon: Icon(_currentProvider == AIProvider.openAI
                ? Icons.psychology
                : Icons.chat_bubble),
            onPressed: _switchProvider,
            tooltip: 'Switch to ${_currentProvider == AIProvider.openAI ? "Gemini" : "OpenAI"}',
          ),
        ],
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
                      color: isUser
                          ? Colors.blue.shade100
                          : (_currentProvider == AIProvider.openAI
                              ? Colors.grey.shade200
                              : Colors.deepPurple.shade50),
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
                    decoration: InputDecoration(
                      hintText: 'Ask ${_currentProvider == AIProvider.openAI ? "OpenAI" : "Gemini"} something...',
                      border: const OutlineInputBorder(),
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