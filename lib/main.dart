import 'dart:io';
import 'package:flutter/material.dart';
import 'package:puzzle_app/routes/routes.dart';
import 'package:puzzle_app/routes/router.dart' as router;
import 'package:window_size/window_size.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowFrame(
        const Rect.fromLTWH((1920 - 432) / 2, (1080 - 888) / 2, 432, 888));
    setWindowMinSize(const Size(345.6, 710.4));
    setWindowMaxSize(const Size(432, 888));
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Puzzle App",
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.startPage,
      onGenerateRoute: router.Router.generateRoute,
    );
  }
}
