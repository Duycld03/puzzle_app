import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_app/blocs/play/play_bloc.dart';

class OptionButton extends StatelessWidget {
  final String title;
  final Color color;
  final String optionName;
  const OptionButton({
    Key? key,
    required this.title,
    required this.optionName,
    this.color = Colors.blue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayBloc, PlayState>(
      builder: (context, state) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: color,
              padding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 10)),
          onPressed: () {
            context.read<PlayBloc>().add(SelectedOption(option: optionName));
            context.read<PlayBloc>().add(LoadQuestions());
          },
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }
}
