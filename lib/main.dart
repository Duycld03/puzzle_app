import 'package:flutter/material.dart';
import 'package:puzzle_app/routes/routes.dart';
import 'package:puzzle_app/routes/router.dart' as router;

void main() {
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
