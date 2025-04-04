import 'package:flutter/material.dart';
// import 'package:ai_chat_plus/ai_chat_plus.dart';
import 'chat_pages/light_chat_page.dart';
import 'chat_pages/dark_chat_page.dart';
import 'chat_pages/custom_chat_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Chat Examples'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildThemeCard(
              context,
              title: 'Light Theme',
              description: 'Clean and bright chat interface',
              icon: Icons.light_mode,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LightChatPage()),
              ),
            ),
            const SizedBox(height: 16),
            _buildThemeCard(
              context,
              title: 'Dark Theme',
              description: 'Modern dark mode interface',
              icon: Icons.dark_mode,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const DarkChatPage()),
              ),
            ),
            const SizedBox(height: 16),
            _buildThemeCard(
              context,
              title: 'Custom Theme',
              description: 'Fully customized chat experience',
              icon: Icons.palette,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CustomChatPage()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon, size: 32),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
      ),
    );
  }
} 