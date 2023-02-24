import 'package:flutter/material.dart';

class PlayPage extends StatelessWidget {
  const PlayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Play")),
      body: const Center(
        child: Text(
          "Play Page",
          style: TextStyle(fontSize: 25),
        ),
      ),
    );
  }
}
