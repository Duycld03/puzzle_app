import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_app/blocs/play/play_bloc.dart';

class TFButton extends StatelessWidget {
  final String title;
  final Color color;
  final String optionName;
  const TFButton({
    required this.title,
    this.color = Colors.blue,
    required this.optionName,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayBloc, PlayState>(
      builder: (context, state) {
        return SizedBox(
          width: 100,
          height: 100,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
              ),
              onPressed: () {
                context
                    .read<PlayBloc>()
                    .add(SelectedOption(option: optionName));
              },
              child: Text(title)),
        );
      },
    );
  }
}
