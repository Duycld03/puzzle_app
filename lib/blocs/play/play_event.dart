part of 'play_bloc.dart';

@immutable
abstract class PlayEvent {}

class SelectedOption extends PlayEvent {
  final String option;
  SelectedOption({required this.option});
}

class LoadQuestions extends PlayEvent {}

class NextQuestion extends PlayEvent {
  final BuildContext context;
  NextQuestion({required this.context});
}

class ShowDialog extends PlayEvent {}

class HiddenDialog extends PlayEvent {}

class FillOptionChanged extends PlayEvent {
  final String fillOption;
  FillOptionChanged({required this.fillOption});
}

class Timeout extends PlayEvent {}
