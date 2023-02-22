part of 'navbar_bloc.dart';

@immutable
abstract class NavbarEvent {}

class HomeTab extends NavbarEvent {}

class QuestionTab extends NavbarEvent {}

class SettingTab extends NavbarEvent {}
