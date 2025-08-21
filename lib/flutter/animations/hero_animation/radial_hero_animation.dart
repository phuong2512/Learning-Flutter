import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter/scheduler.dart';

void main() {
  timeDilation = 5.0;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: ListScreen());
  }
}

class ListScreen extends StatelessWidget {
  ListScreen({super.key});

  final List<Map<String, String>> _hero = [
    {
      'title': 'Hero Image 1',
      'tag': 'hero-image-1',
      'img': 'assets/images/cat_1.png',
    },
    {
      'title': 'Hero Image 2',
      'tag': 'hero-image-2',
      'img': 'assets/images/cat_2.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Radial Hero Animation List')),
      body: ListView.builder(
        itemCount: _hero.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: SizedBox(
              width: 50,
              height: 50,
              child: Hero(
                tag: _hero[index]['tag']!,
                createRectTween: (begin, end) {
                  return MaterialRectCenterArcTween(begin: begin, end: end);
                },
                child: RadialExpansion(
                  maxRadius: 25.0,
                  child: Image.asset(_hero[index]['img']!, fit: BoxFit.cover),
                ),
              ),
            ),
            title: Text(_hero[index]['title']!),
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => DetailScreen(hero: _hero[index]),
                  transitionsBuilder: (_, animation, __, child) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final Map<String, String> hero;

  const DetailScreen({super.key, required this.hero});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(hero['title']!)),
      body: Center(
        child: SizedBox(
          width: 300,
          height: 300,
          child: Hero(
            tag: hero['tag']!,
            createRectTween: (begin, end) {
              return MaterialRectCenterArcTween(begin: begin, end: end);
            },
            child: RadialExpansion(
              maxRadius: 150.0,
              child: Image.asset(hero['img']!, fit: BoxFit.cover),
            ),
          ),
        ),
      ),
    );
  }
}

class RadialExpansion extends StatelessWidget {
  final double maxRadius;
  final Widget child;

  const RadialExpansion({
    super.key,
    required this.maxRadius,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final clipRectSize = 2.0 * (maxRadius / math.sqrt2);
    return ClipOval(
      child: Center(
        child: SizedBox(
          width: clipRectSize,
          height: clipRectSize,
          child: ClipRect(child: child),
        ),
      ),
    );
  }
}
