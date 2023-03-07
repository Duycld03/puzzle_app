import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_app/blocs/play/play_bloc.dart';
import 'package:puzzle_app/pages/PlayPage/fill_option.dart';
import 'package:puzzle_app/pages/PlayPage/quiz_option.dart';
import 'package:puzzle_app/pages/PlayPage/tf_option.dart';

class PlayContent extends StatefulWidget {
  const PlayContent({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  State<PlayContent> createState() => _PlayContentState();
}

class _PlayContentState extends State<PlayContent> {
  List<Icon> _getLife(int life) {
    List<Icon> icons = [];
    for (int i = 0; i < life; i++) {
      icons.add(const Icon(Icons.local_fire_department));
    }
    return icons;
  }

  final List<Widget> options = [
    const QuizOption(),
    const TFOption(),
    const FillOption()
  ];

  @override
  void initState() {
    context.read<PlayBloc>().add(LoadQuestions());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayBloc, PlayState>(
      builder: (context, state) {
        if (state.isGameOver) {
          context.read<PlayBloc>().add(GameOver(context: context));
        }
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: _getLife(state.life),
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Card(
                  margin: EdgeInsets.symmetric(
                      horizontal: widget.size.width * 0.08,
                      vertical: widget.size.height * 0.05),
                  color: Colors.blueGrey,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        state.currentQuestion?.question ?? "",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: widget.size.width * 0.08,
                      vertical: widget.size.height * 0.03),
                  child:
                      options[state.currentQuestion?.category == "Trắc Nghiệm"
                          ? 0
                          : state.currentQuestion?.category == "T/F"
                              ? 1
                              : 2],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
