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
  List<Icon> _getLife(int life) {
    List<Icon> icons = [];
    for (int i = 0; i < life; i++) {
      icons.add(const Icon(Icons.local_fire_department));
    }
    return icons;
  }

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
                  child: LayoutBuilder(
                    builder: (context, constraints) => SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints:
                            BoxConstraints(minHeight: constraints.maxHeight),
                        child: Column(
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
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
