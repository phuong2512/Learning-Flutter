import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}
//
// class MyChangeNotifier extends ChangeNotifier {
//   int _value = 0;
//   int get value => _value;
//
//   void increment() {
//     _value++;
//     notifyListeners();
//   }
// }
//
// class MyApp extends StatelessWidget {
//   final MyChangeNotifier variable = MyChangeNotifier();
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider.value(
//       value: variable, // Tái sử dụng đối tượng hiện có
//       child: MaterialApp(
//         home: Scaffold(
//           body: Center(
//             child: Consumer<MyChangeNotifier>(
//               builder: (context, notifier, _) =>
//                   Text('Value: ${notifier.value}'),
//             ),
//           ),
//           floatingActionButton: FloatingActionButton(
//             onPressed: () => variable.increment(),
//             child: Icon(Icons.add),
//           ),
//         ),
//       ),
//     );

class MyChangeNotifier extends ChangeNotifier {
  int _value = 0;
  int get value => _value;

  void increment() {
    _value++;
    notifyListeners();
}

  @override
  void dispose() {
    print('ChangeNotifier disposed');
    super.dispose();
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final MyChangeNotifier variable = MyChangeNotifier();
  bool showProvider = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: showProvider
              ? ChangeNotifierProvider.value(
                  value: variable,
                  // create: (_) => variable,
                  child: Consumer<MyChangeNotifier>(
                    builder: (context, notifier, _) =>
                        Text('Value: ${notifier.value}'),
                  ),
                )
              : Text('Provider removed'),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () => variable.increment(),
              child: Icon(Icons.add),
            ),
            SizedBox(height: 15),
            FloatingActionButton(
              onPressed: () => setState(() => showProvider = !showProvider),
              child: Icon(showProvider ? Icons.remove : Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
