import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_app/blocs/play/play_bloc.dart';
import 'package:puzzle_app/pages/PlayPage/play_content.dart';
import 'package:puzzle_app/routes/routes.dart';
import 'package:quickalert/quickalert.dart';

class PlayPage extends StatelessWidget {
  const PlayPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: BlocProvider(
        create: (context) => PlayBloc(),
        child: BlocListener<PlayBloc, PlayState>(
          listener: (context, state) {
            if (state.isShow) {
              if (state.isCorrect) {
                QuickAlert.show(
                  context: context,
                  title: "Đúng rồi",
                  type: QuickAlertType.info,
                  onConfirmBtnTap: () {
                    Navigator.of(context).pop();
                    context.read<PlayBloc>().add(NextQuestion());
                  },
                  barrierDismissible: false,
                );
              } else {
                QuickAlert.show(
                  context: context,
                  title: "Sai rồi hoho",
                  text: state.currentQuestion?.explain,
                  type: QuickAlertType.error,
                  onConfirmBtnTap: () {
                    Navigator.of(context).pop();
                    if (state.isGameOver) {
                      Navigator.of(context)
                          .pushReplacementNamed(Routes.mainPage);
                    }
                    context.read<PlayBloc>().add(NextQuestion());
                  },
                  barrierDismissible: false,
                );
              }
              context.read<PlayBloc>().add(HiddenDialog());
            }
          },
          child: PlayContent(size: size),
        ),
      ),
    );
  }
}
