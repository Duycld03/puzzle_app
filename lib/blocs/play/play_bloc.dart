import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:puzzle_app/data/question_table.dart';
import 'package:puzzle_app/models/question.dart';
import 'package:puzzle_app/routes/routes.dart';

part 'play_event.dart';
part 'play_state.dart';

class PlayBloc extends Bloc<PlayEvent, PlayState> {
  PlayBloc() : super(PlayInitial()) {
    on<SelectedOption>((event, emit) {
      print("selected option: ${event.option}");
      if (event.option != state.currentQuestion!.answer) {
        state.minusLife();
        print(state.life);
      } else {
        print("you selected right");
        print(state.life);
      }
    });
    on<LoadQuestions>(
      (event, emit) async {
        final List<Question> list =
            await QuestionTable.instance.getAllQuestion();
        list.shuffle();
        emit(
          state.copyWith(
            life: state.life,
            questions: list,
            isGameOver: state.isGameOver,
          ),
        );
      },
    );
    on<NextQuestion>(
      (event, emit) {
        print("Next question");
        emit(state.copyWith(id: state.id! + 1));
      },
    );
    on<GameOver>(
      (event, emit) {
        print("Game Over");
        emit(state.copyWith(isGameOver: false));
        Navigator.of(event.context).pushReplacementNamed(Routes.mainPage);
      },
    );
  }
}
