import 'package:flutter/material.dart';
import 'package:ai_chat_plus/src/customizechat/widgets.dart';

class ChatSettingsPage extends StatefulWidget {
  final ChatTheme initialTheme;
  final Function(ChatTheme) onThemeUpdated;

  const ChatSettingsPage({
    super.key,
    required this.initialTheme,
    required this.onThemeUpdated,
  });

  @override
  State<ChatSettingsPage> createState() => _ChatSettingsPageState();
}

class _ChatSettingsPageState extends State<ChatSettingsPage> {
  late ChatTheme _currentTheme;

  @override
  void initState() {
    super.initState();
    _currentTheme = widget.initialTheme;
  }

  void _updateTheme(ChatTheme newTheme) {
    setState(() {
      _currentTheme = newTheme;
    });
    widget.onThemeUpdated(newTheme);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat UI Settings'),
      ),
      body: ListView(
        children: [
          _buildSection(
            title: 'Colors',
            children: [
              _buildColorPicker(
                title: 'Primary Color',
                color: _currentTheme.primaryColor,
                onColorChanged: (color) {
                  _updateTheme(_currentTheme.copyWith(primaryColor: color));
                },
              ),
              _buildColorPicker(
                title: 'Background Color',
                color: _currentTheme.backgroundColor,
                onColorChanged: (color) {
                  _updateTheme(_currentTheme.copyWith(backgroundColor: color));
                },
              ),
              _buildColorPicker(
                title: 'User Bubble Color',
                color: _currentTheme.userBubbleColor,
                onColorChanged: (color) {
                  _updateTheme(_currentTheme.copyWith(userBubbleColor: color));
                },
              ),
              _buildColorPicker(
                title: 'AI Bubble Color',
                color: _currentTheme.aiBubbleColor,
                onColorChanged: (color) {
                  _updateTheme(_currentTheme.copyWith(aiBubbleColor: color));
                },
              ),
            ],
          ),
          _buildSection(
            title: 'Text',
            children: [
              _buildColorPicker(
                title: 'User Text Color',
                color: _currentTheme.userTextColor,
                onColorChanged: (color) {
                  _updateTheme(_currentTheme.copyWith(userTextColor: color));
                },
              ),
              _buildColorPicker(
                title: 'AI Text Color',
                color: _currentTheme.aiTextColor,
                onColorChanged: (color) {
                  _updateTheme(_currentTheme.copyWith(aiTextColor: color));
                },
              ),
              _buildSlider(
                title: 'Message Font Size',
                value: _currentTheme.messageTextStyle.fontSize ?? 16,
                min: 12,
                max: 24,
                onChanged: (value) {
                  _updateTheme(_currentTheme.copyWith(
                    messageTextStyle: _currentTheme.messageTextStyle.copyWith(
                      fontSize: value,
                    ),
                  ));
                },
              ),
            ],
          ),
          _buildSection(
            title: 'Bubbles',
            children: [
              _buildSlider(
                title: 'Bubble Radius',
                value: _currentTheme.bubbleRadius,
                min: 8,
                max: 32,
                onChanged: (value) {
                  _updateTheme(_currentTheme.copyWith(bubbleRadius: value));
                },
              ),
              _buildSlider(
                title: 'Avatar Radius',
                value: _currentTheme.avatarRadius,
                min: 16,
                max: 32,
                onChanged: (value) {
                  _updateTheme(_currentTheme.copyWith(avatarRadius: value));
                },
              ),
              _buildSlider(
                title: 'Bubble Max Width',
                value: _currentTheme.bubbleMaxWidth,
                min: 200,
                max: 400,
                onChanged: (value) {
                  _updateTheme(_currentTheme.copyWith(bubbleMaxWidth: value));
                },
              ),
              _buildSwitch(
                title: 'Enable Bubble Shadow',
                value: _currentTheme.bubbleShadow != null,
                onChanged: (value) {
                  _updateTheme(_currentTheme.copyWith(
                    bubbleShadow: value
                        ? BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          )
                        : null,
                  ));
                },
              ),
            ],
          ),
          _buildSection(
            title: 'Input',
            children: [
              _buildColorPicker(
                title: 'Input Text Color',
                color: _currentTheme.inputTextColor,
                onColorChanged: (color) {
                  _updateTheme(_currentTheme.copyWith(inputTextColor: color));
                },
              ),
              _buildColorPicker(
                title: 'Input Background Color',
                color: _currentTheme.inputBackgroundColor,
                onColorChanged: (color) {
                  _updateTheme(_currentTheme.copyWith(inputBackgroundColor: color));
                },
              ),
              _buildColorPicker(
                title: 'Send Button Color',
                color: _currentTheme.sendButtonTheme.color ?? Colors.blue,
                onColorChanged: (color) {
                  _updateTheme(_currentTheme.copyWith(
                    sendButtonTheme: IconThemeData(
                      color: color,
                      size: _currentTheme.sendButtonTheme.size,
                    ),
                  ));
                },
              ),
            ],
          ),
          _buildSection(
            title: 'Presets',
            children: [
              _buildPresetButton(
                title: 'Light Theme',
                onPressed: () {
                  _updateTheme(ChatTheme.light());
                },
              ),
              _buildPresetButton(
                title: 'Dark Theme',
                onPressed: () {
                  _updateTheme(ChatTheme.dark());
                },
              ),
              _buildPresetButton(
                title: 'Custom Purple Theme',
                onPressed: () {
                  _updateTheme(
                    ChatTheme(
                      primaryColor: Colors.purple,
                      userBubbleGradient: const LinearGradient(
                        colors: [Colors.purple, Colors.deepPurple],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      bubbleShadow: BoxShadow(
                        color: Colors.purple.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...children,
        const Divider(),
      ],
    );
  }

  Widget _buildColorPicker({
    required String title,
    required Color color,
    required ValueChanged<Color> onColorChanged,
  }) {
    return ListTile(
      title: Text(title),
      trailing: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Select $title'),
              content: SingleChildScrollView(
                child: ColorPicker(
                  pickerColor: color,
                  onColorChanged: onColorChanged,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Done'),
                ),
              ],
            ),
          );
        },
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey),
          ),
        ),
      ),
    );
  }

  Widget _buildSlider({
    required String title,
    required double value,
    required double min,
    required double max,
    required ValueChanged<double> onChanged,
  }) {
    return ListTile(
      title: Text(title),
      subtitle: Slider(
        value: value,
        min: min,
        max: max,
        onChanged: onChanged,
      ),
      trailing: Text(value.toStringAsFixed(1)),
    );
  }

  Widget _buildSwitch({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
    );
  }

  Widget _buildPresetButton({
    required String title,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(title),
      ),
    );
  }
}

class ColorPicker extends StatelessWidget {
  final Color pickerColor;
  final ValueChanged<Color> onColorChanged;

  const ColorPicker({
    super.key,
    required this.pickerColor,
    required this.onColorChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemCount: Colors.primaries.length,
      itemBuilder: (context, index) {
        final color = Colors.primaries[index];
        return GestureDetector(
          onTap: () => onColorChanged(color),
          child: Container(
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(
                color: pickerColor == color ? Colors.white : Colors.transparent,
                width: 2,
              ),
            ),
          ),
        );
      },
    );
  }
} 