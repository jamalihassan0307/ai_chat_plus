import 'package:flutter/material.dart';
import 'chat_theme.dart';

class CustomTypingIndicator extends StatefulWidget {
  final ChatTheme theme;
  final double dotSize;
  final Duration animationDuration;
  final int dotCount;
  final double dotSpacing;

  const CustomTypingIndicator({
    super.key,
    required this.theme,
    this.dotSize = 8.0,
    this.animationDuration = const Duration(milliseconds: 1500),
    this.dotCount = 3,
    this.dotSpacing = 4.0,
  });

  @override
  State<CustomTypingIndicator> createState() => _CustomTypingIndicatorState();
}

class _CustomTypingIndicatorState extends State<CustomTypingIndicator>
    with TickerProviderStateMixin {
  late List<AnimationController> _animationControllers;
  late List<Animation<double>> _scaleAnimations;
  late List<Animation<double>> _opacityAnimations;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _animationControllers = List.generate(
      widget.dotCount,
      (index) => AnimationController(
        duration: widget.animationDuration,
        vsync: this,
      ),
    );

    _scaleAnimations = _animationControllers.map((controller) {
      return Tween<double>(begin: 0.5, end: 1.0).animate(
        CurvedAnimation(
          parent: controller,
          curve: Curves.easeInOut,
        ),
      );
    }).toList();

    _opacityAnimations = _animationControllers.map((controller) {
      return Tween<double>(begin: 0.3, end: 1.0).animate(
        CurvedAnimation(
          parent: controller,
          curve: Curves.easeInOut,
        ),
      );
    }).toList();

    for (var i = 0; i < widget.dotCount; i++) {
      Future.delayed(Duration(milliseconds: i * 300), () {
        if (mounted) {
          _animationControllers[i].repeat(reverse: true);
        }
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _animationControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: widget.theme.aiBubbleColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: widget.theme.bubbleShadow != null
                  ? [widget.theme.bubbleShadow!]
                  : null,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(widget.dotCount, (index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: widget.dotSpacing),
                  child: AnimatedBuilder(
                    animation: _animationControllers[index],
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _scaleAnimations[index].value,
                        child: Opacity(
                          opacity: _opacityAnimations[index].value,
                          child: Container(
                            width: widget.dotSize,
                            height: widget.dotSize,
                            decoration: BoxDecoration(
                              color: widget.theme.aiTextColor
                                  .withAlpha(179), // 0.7 * 255 ≈ 179
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
