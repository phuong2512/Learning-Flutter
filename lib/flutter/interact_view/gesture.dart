import 'dart:developer';

import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: GestureDemo()));

class GestureDemo extends StatefulWidget {
  const GestureDemo({super.key});

  @override
  State<GestureDemo> createState() => _GestureDemoState();
}

class _GestureDemoState extends State<GestureDemo> {
  String _status = '...';

  void _updateStatus(String status) {
    log(status);
    setState(() {
      _status = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gesture Detector Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => _updateStatus('One Tap'),
              onDoubleTap: () => _updateStatus('Double Tap'),
              onLongPress: () => _updateStatus('Long Tap'),
              onTapDown: (details) => _updateStatus('Tap Down'),
              onTapUp: (details) => _updateStatus('Tap Up'),
              onTapCancel: () => _updateStatus('Tap Cancel'),
              child: Container(
                width: 100,
                height: 100,
                color: Colors.red,
                alignment: Alignment.center,
                child: Text(
                  'Tap here',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ),
            SizedBox(height: 30),
            Text('Event: $_status', style: TextStyle(fontSize: 15)),
          ],
        ),
      ),
    );
  }
}
