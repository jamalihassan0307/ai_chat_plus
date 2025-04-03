import 'package:flutter/material.dart';

class TypingIndicator extends StatefulWidget {
  final Color dotColor;
  final double dotSize;
  final Duration animationDuration;

  const TypingIndicator({
    super.key,
    this.dotColor = Colors.grey,
    this.dotSize = 8.0,
    this.animationDuration = const Duration(milliseconds: 1500),
  });

  @override
  State<TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator>
    with TickerProviderStateMixin {
  late List<AnimationController> _animationControllers;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _animationControllers = List.generate(
      3,
      (index) => AnimationController(
        duration: widget.animationDuration,
        vsync: this,
      ),
    );

    _animations = _animationControllers.map((controller) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: controller,
          curve: Curves.easeInOut,
        ),
      );
    }).toList();

    for (var i = 0; i < 3; i++) {
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
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(3, (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: AnimatedBuilder(
              animation: _animations[index],
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, -4 * _animations[index].value),
                  child: Container(
                    width: widget.dotSize,
                    height: widget.dotSize,
                    decoration: BoxDecoration(
                      color: widget.dotColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
