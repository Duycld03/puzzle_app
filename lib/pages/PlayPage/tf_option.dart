import 'package:flutter/material.dart';
import 'package:puzzle_app/pages/PlayPage/tf_button.dart';

class TFOption extends StatelessWidget {
  const TFOption({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          TFButton(title: "True", optionName: "A"),
          TFButton(title: "False", color: Colors.red, optionName: "B"),
        ],
      ),
    );
  }
}
