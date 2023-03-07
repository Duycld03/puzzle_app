import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_app/blocs/play/play_bloc.dart';
import 'package:puzzle_app/pages/PlayPage/option_button.dart';

class QuizOption extends StatelessWidget {
  const QuizOption({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: BlocBuilder<PlayBloc, PlayState>(
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  OptionButton(
                    title: state.options[0],
                    color: Colors.pink,
                    optionName: state.options[0],
                  ),
                  OptionButton(
                    title: state.options[1],
                    color: Colors.purple,
                    optionName: state.options[1],
                  ),
                  OptionButton(
                    title: state.options[2],
                    color: Colors.cyan,
                    optionName: state.options[2],
                  ),
                  OptionButton(
                    title: state.options[3],
                    color: Colors.orange,
                    optionName: state.options[3],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
