import 'package:flutter/material.dart';

class UserQuestionPage extends StatelessWidget {
  const UserQuestionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Dismissible(
            key: UniqueKey(),
            background: Container(color: Colors.red),
            child: const ListTile(
              leading: Text("1"),
              title: Text("cau hoi"),
            ),
          ),
          Dismissible(
            key: UniqueKey(),
            child: const ListTile(
              leading: Text("2"),
              title: Text("cau hoi"),
            ),
          ),
          Dismissible(
            key: UniqueKey(),
            child: const ListTile(
              leading: Text("3"),
              title: Text("cau hoi"),
            ),
          ),
        ],
      ),
    );
  }
}
