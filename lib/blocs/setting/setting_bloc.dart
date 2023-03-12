import 'package:bloc/bloc.dart';
import 'package:group_button/group_button.dart';
import 'package:meta/meta.dart';
import 'package:puzzle_app/data/question_table.dart';
import 'package:puzzle_app/models/question.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  final String userQuestionSet = "Bộ câu hỏi tự thêm";
  final String questionSet = "Bộ câu hỏi của App";

  SettingBloc() : super(SettingInitial()) {
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

    on<ChangeDurationTimeout>((event, emit) {
      print(event.durationTimeout);
      _changeDurationTimeout(event.durationTimeout);
      emit(state.copyWith(durationTimeout: event.durationTimeout));
    });

    on<LoadSetting>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      bool isUserQuestionSet = prefs.getBool("isUserQuestionSet") ?? false;
      int durationTimeout = prefs.getInt("durationTimeout") ?? 30;
      state.groupButtonCtrl.selectIndex(_selectIndex(durationTimeout));
      final List<Question> list =
          await QuestionTable.instance.getAllUserQuestion();
      if (list.isEmpty) {
        _changeQuestionSet(false);
        emit(state.copyWith(
          questionSet: questionSet,
          isUserQuestionSet: false,
          isValid: false,
          durationTimeout: durationTimeout,
        ));
        return;
      }
      emit(state.copyWith(isValid: true, durationTimeout: durationTimeout));
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

  _changeDurationTimeout(int durationTimeout) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("durationTimeout", durationTimeout);
  }

  _selectIndex(int durationTimeout) {
    switch (durationTimeout) {
      case 30:
        return 0;
      case 45:
        return 1;
      case 60:
        return 2;
    }
  }
}
