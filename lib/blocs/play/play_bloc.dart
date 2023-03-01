import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:puzzle_app/data/question_table.dart';
import 'package:puzzle_app/models/question.dart';

part 'play_event.dart';
part 'play_state.dart';

class PlayBloc extends Bloc<PlayEvent, PlayState> {
  PlayBloc() : super(PlayInitial()) {
    on<SelectedOption>((event, emit) {
      print("selected option: ${event.option}");
      if (event.option != state.answer) {
        state.minusLife();
        print(state.life);
      } else {
        print("you selected right");
        print(state.life);
      }
    });
    _checkGameOver() {}
    on<LoadQuestions>((event, emit) async {
      print("LoadQuestion");
      final List<Question> list = await QuestionTable.instance.getAllQuestion();
      Question q1 = list[0];
      final List<String> options = [
        q1.optionA,
        q1.optionB,
        q1.optionC,
        q1.optionD,
      ];
      emit(
        state.copyWith(
            life: state.life,
            question: q1.question,
            options: options,
            answer: q1.answer,
            topicID: 1,
            categoryID: q1.categoryID),
      );
    });
  }
}
