import 'package:bloc/bloc.dart';
import 'package:group_button/group_button.dart';
import 'package:meta/meta.dart';
import 'package:puzzle_app/data/question_table.dart';
import 'package:puzzle_app/models/question.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  static const String _userQuestionSetKey = "isUserQuestionSet";
  static const String _durationTimeoutKey = "durationTimeout";
  static const String _defaultUserQuestionSet = "Bộ câu hỏi tự thêm";
  static const String _defaultAppQuestionSet = "Bộ câu hỏi của App";

  late SharedPreferences _prefs;

  SettingBloc() : super(SettingInitial()) {
    on<ChangeQuestionSet>((event, emit) => _changeQuestionSet(event, emit));
    on<ChangeDurationTimeout>((event, emit) => _changeDurationTimeout(event, emit));
    on<LoadSetting>((event, emit) => _loadSetting(emit));
  }

  /// Initialize SharedPreferences
  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Change question set (user or app)
  Future<void> _changeQuestionSet(
    ChangeQuestionSet event,
    Emitter<SettingState> emit,
  ) async {
    if (event.isUserQuestionSet) {
      final List<Question> userQuestions =
          await QuestionTable.instance.getAllUserQuestion();

      if (userQuestions.isEmpty) {
        // No user questions, fallback to app questions
        await _prefs.setBool(_userQuestionSetKey, false);
        emit(state.copyWith(
          questionSet: _defaultAppQuestionSet,
          isUserQuestionSet: false,
          isValid: false,
        ));
        return;
      }

      // User questions exist, save preference
      await _prefs.setBool(_userQuestionSetKey, true);
      emit(state.copyWith(
        questionSet: _defaultUserQuestionSet,
        isUserQuestionSet: true,
        isValid: true,
      ));
    } else {
      // Switch to app questions
      await _prefs.setBool(_userQuestionSetKey, false);
      emit(state.copyWith(
        questionSet: _defaultAppQuestionSet,
        isUserQuestionSet: false,
        isValid: true,
      ));
    }
  }

  /// Change timeout duration
  Future<void> _changeDurationTimeout(
    ChangeDurationTimeout event,
    Emitter<SettingState> emit,
  ) async {
    await _prefs.setInt(_durationTimeoutKey, event.durationTimeout);
    state.groupButtonCtrl.selectIndex(_getTimeoutIndex(event.durationTimeout));
    emit(state.copyWith(durationTimeout: event.durationTimeout));
  }

  /// Load settings from SharedPreferences
  Future<void> _loadSetting(Emitter<SettingState> emit) async {
    final bool isUserQuestionSet =
        _prefs.getBool(_userQuestionSetKey) ?? false;
    final int durationTimeout =
        _prefs.getInt(_durationTimeoutKey) ?? 30;

    // Set UI controller to current timeout value
    state.groupButtonCtrl.selectIndex(_getTimeoutIndex(durationTimeout));

    // Check if user questions exist
    final List<Question> userQuestions =
        await QuestionTable.instance.getAllUserQuestion();

    if (userQuestions.isEmpty) {
      // No user questions available
      emit(state.copyWith(
        questionSet: _defaultAppQuestionSet,
        isUserQuestionSet: false,
        isValid: false,
        durationTimeout: durationTimeout,
      ));
      return;
    }

    // User questions exist
    final String questionSet = isUserQuestionSet
        ? _defaultUserQuestionSet
        : _defaultAppQuestionSet;

    emit(state.copyWith(
      questionSet: questionSet,
      isUserQuestionSet: isUserQuestionSet,
      isValid: true,
      durationTimeout: durationTimeout,
    ));
  }

  /// Get GroupButton index from timeout duration
  int _getTimeoutIndex(int durationTimeout) {
    switch (durationTimeout) {
      case 30:
        return 0;
      case 45:
        return 1;
      case 60:
        return 2;
      default:
        return 0;
    }
  }
}
