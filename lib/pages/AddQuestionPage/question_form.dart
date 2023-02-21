import "package:flutter/material.dart";

class QuestionForm extends StatelessWidget {
  final String title;
  final int limit;
  final int lines;
  const QuestionForm(
      {Key? key, required this.title, this.limit = 300, this.lines = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                // color: AppColors.primary,
              ),
            ),
            Text(
              "0/$limit",
              style: const TextStyle(
                // color: AppColors.primary,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const Padding(padding: EdgeInsets.only(top: 10)),
        TextField(
          maxLines: lines,
          decoration: const InputDecoration(
            // focusedBorder: OutlineInputBorder(
            //     borderSide: BorderSide(color: Colors.purple, width: 2),
            //     ),
            border: OutlineInputBorder(),
          ),
        ),
        const Padding(padding: EdgeInsets.only(bottom: 20)),
      ],
    );
  }
}
