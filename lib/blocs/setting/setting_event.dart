part of 'setting_bloc.dart';

@immutable
abstract class SettingEvent {}

class ChangeQuestionSet extends SettingEvent {
  final bool isUserQuestionSet;
  ChangeQuestionSet({required this.isUserQuestionSet});
}

class LoadSetting extends SettingEvent {}
