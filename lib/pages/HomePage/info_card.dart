import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({Key? key, required this.title, required this.amount})
      : super(key: key);
  final String title;
  final int amount;

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      color: Colors.black54,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: textStyle,
                ),
                Text(
                  "$amount",
                  style: textStyle,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
