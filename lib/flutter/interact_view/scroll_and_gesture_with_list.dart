import 'dart:developer';

import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: ScrollGestureExample()));

class ScrollGestureExample extends StatefulWidget {
  const ScrollGestureExample({super.key});

  @override
  State<ScrollGestureExample> createState() => _ScrollGestureExampleState();
}

class _ScrollGestureExampleState extends State<ScrollGestureExample> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrollEnabled = true;
  double _scrollOffset = 0;
  List<String> items = List.generate(30, (index) => 'Item ${index + 1}');

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        _scrollOffset = _scrollController.offset;
      });
    });
  }

  void _toggleScroll() {
    setState(() {
      _isScrollEnabled = !_isScrollEnabled;
    });
  }

  void _removeItem(int index) {
    setState(() {
      items.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Scroll & Gesture Demo"),
          actions: [
            IconButton(
              icon: Icon(_isScrollEnabled ? Icons.lock_open : Icons.lock),
              onPressed: _toggleScroll,
            ),
          ],
        ),
        body: Column(
          children: [
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              padding: EdgeInsets.all(10),
              color: Colors.amber,
              child: Text("Scroll offset: ${_scrollOffset.toStringAsFixed(1)}"),
            ),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                physics: _isScrollEnabled
                    ? AlwaysScrollableScrollPhysics()
                    : NeverScrollableScrollPhysics(),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: ValueKey(items[index]),
                    direction: DismissDirection.startToEnd,
                    onDismissed: (direction) {
                      _removeItem(index);
                    },
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 20),
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                    child: ListTile(
                      title: Text(items[index]),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      onTap: () {
                        log('Clicked on item ${index+1}');
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
