part of 'name_form_bloc.dart';

@immutable
abstract class NameFormEvent {}

class NameChanged extends NameFormEvent {
  final String name;
  NameChanged({required this.name});
}

class LoadName extends NameFormEvent {}

class Start extends NameFormEvent {}
