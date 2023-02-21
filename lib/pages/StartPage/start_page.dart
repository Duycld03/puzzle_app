import 'package:flutter/material.dart';
import 'package:puzzle_app/pages/StartPage/input_name_form.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          flex: 1,
          child: Container(color: Colors.amber),
        ),
        const Expanded(
          flex: 1,
          child: InputNameForm(),
        ),
      ],
    ));
  }
}
