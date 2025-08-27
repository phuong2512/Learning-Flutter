import 'package:flutter/material.dart';

abstract class CustomWidget {
  Widget build();
}

class TextWidget implements CustomWidget {
  final String text;

  TextWidget(this.text);

  @override
  Widget build() {
    return Text(text, style: TextStyle(fontSize: 20));
  }
}

abstract class WidgetDecorator implements CustomWidget {
  final CustomWidget widget;

  WidgetDecorator(this.widget);

  @override
  Widget build();
}

class BorderDecorator extends WidgetDecorator {
  BorderDecorator(super.widget);

  @override
  Widget build() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(8),
      child: widget.build(),
    );
  }
}

class BoldTextDecorator extends WidgetDecorator {
  BoldTextDecorator(super.widget);

  @override
  Widget build() {
    return DefaultTextStyle(
      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
      child: widget.build(),
    );
  }

}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final basicWidget = TextWidget('Hello World!');
    final widgetWithBorder = BorderDecorator(basicWidget);
    final decoratedWidget = BorderDecorator(BoldTextDecorator(basicWidget));
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Decorator Pattern Example')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Original Widget:'),
              basicWidget.build(),
              SizedBox(height: 20),
              Text('Widget with Border:'),
              widgetWithBorder.build(),
              SizedBox(height: 20),
              Text('Widget with border and bold text:'),
              decoratedWidget.build(),
            ],
          ),
        ),
      ),
    );
  }
}
