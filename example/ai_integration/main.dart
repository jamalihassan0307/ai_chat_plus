import 'package:flutter/material.dart';
import 'pages/gemini_page.dart';
import 'pages/openai_page.dart';
import 'pages/claude_page.dart';

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
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.deepPurple.shade100,
              Colors.blue.shade100,
              Colors.teal.shade100,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'AI Chat Plus',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 40),
              _buildAIButton(
                context,
                'Chat with Gemini',
                Icons.psychology,
                Colors.deepPurple,
                const GeminiChatPage(),
              ),
              const SizedBox(height: 20),
              _buildAIButton(
                context,
                'Chat with OpenAI',
                Icons.chat_bubble,
                Colors.blue,
                const OpenAIChatPage(),
              ),
              const SizedBox(height: 20),
              _buildAIButton(
                context,
                'Chat with Claude',
                Icons.auto_awesome,
                Colors.teal,
                const ClaudeChatPage(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAIButton(BuildContext context, String title, IconData icon,
      Color color, Widget page) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromRGBO(
            (color.value >> 16) & 0xFF, // Extracts red
            (color.value >> 8) & 0xFF, // Extracts green
            color.value & 0xFF, // Extracts blue
            0.1,
          ),
          foregroundColor: color,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 28),
            const SizedBox(width: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
