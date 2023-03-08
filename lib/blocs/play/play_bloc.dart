import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:puzzle_app/data/question_table.dart';
import 'package:puzzle_app/models/question.dart';
import 'package:puzzle_app/routes/routes.dart';

part 'play_event.dart';
part 'play_state.dart';

class PlayBloc extends Bloc<PlayEvent, PlayState> {
  PlayBloc() : super(PlayInitial()) {
    on<ShowDialog>((event, emit) => emit(state.copyWith(isShow: true)));
    on<HiddenDialog>((event, emit) => emit(state.copyWith(isShow: false)));
    on<SelectedOption>((event, emit) => _selectedOption(event, emit));
    on<LoadQuestions>((event, emit) => _loadQuestions(emit));
    on<NextQuestion>((event, emit) => _nextAndChangeOptions(emit));
    on<GameOver>(
      (event, emit) {
        emit(state.copyWith(isGameOver: false));
        Navigator.of(event.context).pushReplacementNamed(Routes.mainPage);
      },
    );
    on<FillOptionChanged>(
        (event, emit) => emit(state.copyWith(fillOption: event.fillOption)));
  }
  _nextAndChangeOptions(Emitter emit) {
    if (state.questions.isEmpty) {
      print("empty");
      return;
    }
    int id = 0;
    if (state.isLoaded) {
      id = state.id! + 1;
    }
    if (id == state.questions.length) {
      print("end");
      emit(state.copyWith(id: state.questions.length - 1));
      return;
    }
    Question newQuestion = state.questions[id];
    if (newQuestion.category != "Trắc Nghiệm") {
      state.fillOptionCtrls.clear();
      emit(state.copyWith(id: id, fillOption: ""));
      return;
    }
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
    emit(state.copyWith(id: id, options: options, answer: answer));
  }

  _loadQuestions(Emitter emit) async {
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
    emit(state.copyWith(isLoaded: true));
  }

  _selectedOption(SelectedOption event, Emitter emit) {
    print("selected option: ${event.option}");
    if (state.currentQuestion?.category == "Trắc Nghiệm") {
      if (event.option != state.answer) {
        state.minusLife();
        emit(state.copyWith(isCorrect: false, isShow: true));
        return;
      }
      emit(state.copyWith(isCorrect: true, isShow: true));
      return;
    }
    if (state.currentQuestion?.category == "T/F") {
      if (event.option != state.currentQuestion?.answer) {
        state.minusLife();
        emit(state.copyWith(isCorrect: false, isShow: true));
        return;
      }
      emit(state.copyWith(isCorrect: true, isShow: true));
      return;
    }
    if (event.option.toLowerCase() != state.currentQuestion?.answer) {
      state.minusLife();
      emit(state.copyWith(isCorrect: false, isShow: true));
      return;
    }
    emit(state.copyWith(isCorrect: true, isShow: true));
  }
}
