part of 'setting_bloc.dart';

@immutable
class SettingState {
  final String questionSet;
  final bool isUserQuestionSet;
  final bool isValid;

  const SettingState({
    required this.questionSet,
    required this.isUserQuestionSet,
    required this.isValid,
  });

  SettingState copyWith({
    String? questionSet,
    bool? isUserQuestionSet,
    bool? isValid,
  }) =>
      SettingState(
        questionSet: questionSet ?? this.questionSet,
        isUserQuestionSet: isUserQuestionSet ?? this.isUserQuestionSet,
        isValid: isValid ?? this.isValid,
      );
}

class SettingInitial extends SettingState {
  const SettingInitial()
      : super(
          questionSet: "Bộ câu hỏi của App",
          isUserQuestionSet: false,
          isValid: true,
        );
}
