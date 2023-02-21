import "package:flutter/material.dart";
import 'package:puzzle_app/values/app_colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.primary,
        title: const Text("Puzzle App"),
      ),
      body: Column(children: const [Text("Name")]),
    );
  }
}
