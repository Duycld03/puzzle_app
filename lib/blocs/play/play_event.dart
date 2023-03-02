part of 'play_bloc.dart';

@immutable
abstract class PlayEvent {}

class SelectedOption extends PlayEvent {
  final String option;
  SelectedOption({required this.option});
}

class LoadQuestions extends PlayEvent {}

class NextQuestion extends PlayEvent {}

class GameOver extends PlayEvent {
  final BuildContext context;
  GameOver({required this.context});
}
