import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_app/blocs/play/play_bloc.dart';
import 'package:puzzle_app/pages/PlayPage/option_button.dart';

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
  @override
  void initState() {
    context.read<PlayBloc>().add(LoadQuestions());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayBloc, PlayState>(
      builder: (context, state) {
        return FutureBuilder(
          future: state.delay(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    color: Colors.blue,
                    height: widget.size.height * 0.08,
                    child: const Text(
                      "",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
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
                            state.question,
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
                      child: LayoutBuilder(
                        builder: (context, constraints) =>
                            SingleChildScrollView(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                                minHeight: constraints.maxHeight),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                OptionButton(
                                  title: state.options[0],
                                  color: Colors.pink,
                                  optionName: "A",
                                ),
                                OptionButton(
                                  title: state.options[1],
                                  color: Colors.purple,
                                  optionName: "B",
                                ),
                                OptionButton(
                                  title: state.options[2],
                                  color: Colors.cyan,
                                  optionName: "C",
                                ),
                                OptionButton(
                                  title: state.options[3],
                                  color: Colors.orange,
                                  optionName: "D",
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        );
      },
    );
  }
}
