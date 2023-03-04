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
      if (event.option != state.answer) {
        state.minusLife();
        print(state.life);
      }
    });
    on<LoadQuestions>(
      (event, emit) async {
        final List<Question> list =
            await QuestionTable.instance.getAllUserQuestion();
        list.shuffle();
        emit(
          state.copyWith(
            life: state.life,
            questions: list,
            isGameOver: state.isGameOver,
          ),
        );
        _nextAndChangeOptions(emit);
      },
    );
    on<NextQuestion>(
      (event, emit) {
        print("Next question");
        _nextAndChangeOptions(emit);
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
  _nextAndChangeOptions(Emitter emit) {
    if (state.questions.isNotEmpty) {
      Question newQuestion = state.questions[state.id! + 1];
      if (newQuestion.category == "Trắc nghiệm") {
        Map<String, dynamic> optionList = {
          "A": newQuestion.optionA!,
          "B": newQuestion.optionB!,
          "C": newQuestion.optionC!,
          "D": newQuestion.optionD!,
        };
        List<String> options = [];
        String answer = optionList[newQuestion.answer];
        optionList.forEach((key, value) {
          options.add(value);
        });
        options.shuffle();
        print(options);
        emit(state.copyWith(
            id: state.id! + 1, options: options, answer: answer));
      } else {
        emit(state.copyWith(id: state.id! + 1));
      }
    } else {
      print("empty");
    }
  }
}
