import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_company/view/pages/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBa15X30URztoc1KT-qJyTiEoMN4MbILl0",
      appId: "1:786020451220:web:3b50237bd861c7fe980581",
      messagingSenderId: "786020451220",
      projectId: "aumet-task-909b8",
    ),
  );
  runApp(const ProviderScope(child: TaskAumet()));
}

class TaskAumet extends StatelessWidget {
  const TaskAumet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aumit Task',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}
