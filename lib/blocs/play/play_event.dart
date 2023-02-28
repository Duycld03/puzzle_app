part of 'play_bloc.dart';

@immutable
abstract class PlayEvent {}

class SelectedOption extends PlayEvent {
  final String option;
  SelectedOption({required this.option});
}
