part of 'setting_bloc.dart';

@immutable
class SettingState {
  final String questionSet;
  final bool isUserQuestionSet;
  final bool isValid;
  final GroupButtonController groupButtonCtrl;
  final int durationTimeout;

  const SettingState({
    required this.questionSet,
    required this.isUserQuestionSet,
    required this.isValid,
    required this.groupButtonCtrl,
    required this.durationTimeout,
  });

  SettingState copyWith({
    String? questionSet,
    bool? isUserQuestionSet,
    bool? isValid,
    GroupButtonController? groupButtonCtrl,
    int? durationTimeout,
  }) =>
      SettingState(
        questionSet: questionSet ?? this.questionSet,
        isUserQuestionSet: isUserQuestionSet ?? this.isUserQuestionSet,
        isValid: isValid ?? this.isValid,
        groupButtonCtrl: groupButtonCtrl ?? this.groupButtonCtrl,
        durationTimeout: durationTimeout ?? this.durationTimeout,
      );
}

class SettingInitial extends SettingState {
  SettingInitial()
      : super(
          questionSet: "Bộ câu hỏi của App",
          isUserQuestionSet: false,
          isValid: true,
          groupButtonCtrl: GroupButtonController(),
          durationTimeout: 0,
        );
}
