part of 'setting_bloc.dart';

@immutable
abstract class SettingEvent {}

class ChangeQuestionSet extends SettingEvent {
  final bool isUserQuestionSet;
  ChangeQuestionSet({required this.isUserQuestionSet});
}

class ChangeDurationTimeout extends SettingEvent {
  final int durationTimeout;
  ChangeDurationTimeout({required this.durationTimeout});
}

class LoadSetting extends SettingEvent {}
