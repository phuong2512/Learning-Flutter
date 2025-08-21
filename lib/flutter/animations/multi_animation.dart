import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(AnimatedWidgetDemo());

class AnimatedWidgetDemo extends StatefulWidget {
  const AnimatedWidgetDemo({super.key});

  @override
  State<AnimatedWidgetDemo> createState() => _AnimatedWidgetDemoState();
}

class _AnimatedWidgetDemoState extends State<AnimatedWidgetDemo>
    with TickerProviderStateMixin {
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotateAnimation;
  late Animation<Color?> _colorAnimation;
  late AnimationController _scaleAnimationController;
  late AnimationController _rotateAnimationController;
  late AnimationController _colorAnimationController;

  @override
  void initState() {
    super.initState();
    _scaleAnimationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _rotateAnimationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _colorAnimationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1,
      end: 5,
    ).animate(_scaleAnimationController);
    _rotateAnimation = Tween<double>(
      begin: 0,
      end: 2 * pi,
    ).animate(_rotateAnimationController);
    _colorAnimation = ColorTween(
      begin: Colors.red,
      end: Colors.green,
    ).animate(_colorAnimationController);
    _scaleAnimationController.repeat(reverse: true);
    _colorAnimationController.repeat(reverse: true);
    _rotateAnimationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          AnimatedRotationLogo(
            rotationAnimation: _rotateAnimation,
            scaleAnimation: _scaleAnimation,
          ),
          SizedBox(height: 50),
          AnimatedBuilder(
            animation: Listenable.merge([_rotateAnimation, _colorAnimation]),
            builder: (context, child) => Transform.rotate(
              angle: _rotateAnimation.value,
              child: Container(
                decoration: BoxDecoration(
                  color: _colorAnimation.value,
                  border: Border.all(color: Colors.blue),
                ),
                height: 100,
                width: 100,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedRotationLogo extends AnimatedWidget {
  final Animation<double> scaleAnimation;
  final Animation<double> rotationAnimation;

  AnimatedRotationLogo({
    super.key,
    required this.scaleAnimation,
    required this.rotationAnimation,
  }) : super(listenable: Listenable.merge([scaleAnimation, rotationAnimation]));

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotationAnimation.value,
      child: Transform.scale(
        scale: scaleAnimation.value,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.greenAccent),
          ),
          child: FlutterLogo(),
        ),
      ),
    );
  }
}
