part of 'question_form_bloc.dart';

@immutable
abstract class QuestionFormEvent {}

class QuestionChanged extends QuestionFormEvent {
  final String question;
  QuestionChanged({required this.question});
}

class AnswerAChanged extends QuestionFormEvent {
  final String answerA;
  AnswerAChanged({required this.answerA});
}

class AnswerBChanged extends QuestionFormEvent {
  final String answerB;
  AnswerBChanged({required this.answerB});
}

class AnswerCChanged extends QuestionFormEvent {
  final String answerC;
  AnswerCChanged({required this.answerC});
}

class AnswerDChanged extends QuestionFormEvent {
  final String answerD;
  AnswerDChanged({required this.answerD});
}

class OptionsChanged extends QuestionFormEvent {
  final String option;
  OptionsChanged({required this.option});
}

class CategoryChanged extends QuestionFormEvent {
  final int category;
  CategoryChanged({required this.category});
}

class SubmitForm extends QuestionFormEvent {}
