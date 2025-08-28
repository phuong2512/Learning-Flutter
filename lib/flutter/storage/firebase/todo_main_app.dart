import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:learning_flutter/firebase_options.dart';
import 'package:learning_flutter/flutter/storage/firebase/remote_config_service.dart';
import 'package:learning_flutter/flutter/storage/firebase/todo_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final remoteConfigService = RemoteConfigService();
  await remoteConfigService.initialize();

  runApp(FirebaseMainAppDemo(remoteConfigService: remoteConfigService));
}

class FirebaseMainAppDemo extends StatefulWidget {
  final RemoteConfigService remoteConfigService;

  const FirebaseMainAppDemo({super.key, required this.remoteConfigService});

  @override
  State<FirebaseMainAppDemo> createState() => _FirebaseMainAppDemoState();
}

class _FirebaseMainAppDemoState extends State<FirebaseMainAppDemo> {
  @override
  void initState() {
    super.initState();
    widget.remoteConfigService.setOnConfigChanged(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorHex = widget.remoteConfigService.getPrimaryColor();
    final floatingActionButtonShape = widget.remoteConfigService
        .getFloatingActionButtonShape();

    return MaterialApp(
      title: 'Todo App Firebase',
      theme: ThemeData(primaryColor: Color(int.parse(colorHex))),
      debugShowCheckedModeBanner: false,
      home: TodoScreen(floatingActionButtonShape: floatingActionButtonShape),
    );
  }
}
