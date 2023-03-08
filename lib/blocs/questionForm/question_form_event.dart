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

class OptionChanged extends QuestionFormEvent {
  final String option;
  OptionChanged({required this.option});
}

class FillAnswerChanged extends QuestionFormEvent {
  final String fillAnswer;
  FillAnswerChanged({required this.fillAnswer});
}

class CategoryChanged extends QuestionFormEvent {
  final String category;
  CategoryChanged({required this.category});
}

class TopicChanged extends QuestionFormEvent {
  final int topicID;
  TopicChanged({required this.topicID});
}

class ExplainChanged extends QuestionFormEvent {
  final String explain;
  ExplainChanged({required this.explain});
}

class SubmitForm extends QuestionFormEvent {
  final BuildContext context;
  SubmitForm({required this.context});
}
