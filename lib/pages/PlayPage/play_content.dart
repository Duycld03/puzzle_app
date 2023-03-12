import 'package:circular_countdown_timer/circular_countdown_timer.dart';
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
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: CircularCountDownTimer(
                    width: 38,
                    height: 38,
                    duration: state.durationTimeout,
                    controller: state.countdownCtrl,
                    fillColor: Colors.white,
                    ringColor: Colors.blue,
                    strokeCap: StrokeCap.round,
                    isReverse: true,
                    textStyle: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                    onComplete: () {
                      context.read<PlayBloc>().add(Timeout());
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.question_answer_sharp),
                        const Padding(padding: EdgeInsets.only(left: 8)),
                        Text("${state.id! + 1}"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: _getLife(state.life),
                    ),
                  ],
                ),
              ],
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
