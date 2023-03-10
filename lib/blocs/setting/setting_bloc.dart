import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:puzzle_app/data/question_table.dart';
import 'package:puzzle_app/models/question.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  final String userQuestionSet = "Bộ câu hỏi tự thêm";
  final String questionSet = "Bộ câu hỏi của App";

  SettingBloc() : super(const SettingInitial()) {
    on<ChangeQuestionSet>((event, emit) async {
      if (event.isUserQuestionSet) {
        List<Question> list = await QuestionTable.instance.getAllUserQuestion();
        if (list.isEmpty) {
          _changeQuestionSet(false);
          emit(state.copyWith(
            questionSet: questionSet,
            isUserQuestionSet: false,
            isValid: false,
          ));
          return;
        }
        _changeQuestionSet(true);
        emit(state.copyWith(
          questionSet: userQuestionSet,
          isUserQuestionSet: true,
        ));
        return;
      }

      _changeQuestionSet(false);
      emit(state.copyWith(
        questionSet: questionSet,
        isUserQuestionSet: false,
      ));
    });

    on<LoadSetting>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      bool isUserQuestionSet = prefs.getBool("isUserQuestionSet") ?? false;
      final List<Question> list =
          await QuestionTable.instance.getAllUserQuestion();
      if (list.isEmpty) {
        _changeQuestionSet(false);
        emit(state.copyWith(
            questionSet: questionSet,
            isUserQuestionSet: false,
            isValid: false));
        return;
      }
      emit(state.copyWith(isValid: true));
      if (isUserQuestionSet) {
        emit(state.copyWith(
          questionSet: userQuestionSet,
          isUserQuestionSet: true,
        ));
      }
    });
  }

  _changeQuestionSet(bool isUserQuestionSet) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isUserQuestionSet", isUserQuestionSet);
  }
}
