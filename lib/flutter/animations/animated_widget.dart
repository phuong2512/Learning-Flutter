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
  late Animation<double> scaleAnimation;
  late Animation<double> rotateAnimation;
  late AnimationController scaleAnimationcController;
  late AnimationController rotateAnimationController;

  @override
  void initState() {
    super.initState();
    scaleAnimationcController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    rotateAnimationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    scaleAnimation = Tween<double>(
      begin: 0,
      end: 150,
    ).animate(scaleAnimationcController);
    rotateAnimation = Tween<double>(
      begin: 0,
      end: 2 * pi,
    ).animate(rotateAnimationController);
    scaleAnimationcController.repeat(reverse: true);
    rotateAnimationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          AnimatedFixSizeLogo(animation: scaleAnimation),
          AnimatedRotationLogo(animation: rotateAnimation),
        ],
      ),
    );
  }

  @override
  void dispose() {
    scaleAnimationcController.dispose();
    rotateAnimationController.dispose();
    super.dispose();
  }
}

class AnimatedRotationLogo extends AnimatedWidget {
  const AnimatedRotationLogo({super.key, required Animation<double> animation})
    : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation;
    return Transform.rotate(
      angle: animation.value,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.greenAccent),
        ),
        child: FlutterLogo(size: 150),
      ),
    );
  }
}

class AnimatedFixSizeLogo extends AnimatedWidget {
  const AnimatedFixSizeLogo({super.key, required Animation<double> animation})
    : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation;
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.red)),
      height: animation.value,
      width: animation.value,
      child: FlutterLogo(),
    );
  }
}
