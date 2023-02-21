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
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        backgroundColor: AppColors.primary,
        currentIndex: 3,
        items: const [
          BottomNavigationBarItem(
              label: "Home",
              icon: Icon(Icons.home),
              backgroundColor: Colors.red),
          BottomNavigationBarItem(
              label: "Question",
              icon: Icon(Icons.flag),
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              label: "Rank",
              icon: Icon(Icons.home),
              backgroundColor: Colors.yellow),
          BottomNavigationBarItem(
              label: "Setting",
              icon: Icon(Icons.home),
              backgroundColor: Colors.green),
        ],
        onTap: (value) => print(value),
      ),
    );
  }
}
