part of 'question_form_bloc.dart';

@immutable
class QuestionFormState {
  final TextEditingController questionCtrls;
  final List<TextEditingController> textCtrls;
  final String question;
  final String option;
  final String answerA;
  final String answerB;
  final String answerC;
  final String answerD;
  final int category;

  const QuestionFormState({
    required this.question,
    required this.option,
    required this.answerA,
    required this.answerB,
    required this.answerC,
    required this.answerD,
    required this.category,
    required this.questionCtrls,
    required this.textCtrls,
  });

  bool get isValid =>
      question.isNotEmpty &&
      option.isNotEmpty &&
      answerA.isNotEmpty &&
      answerB.isNotEmpty &&
      answerC.isNotEmpty &&
      answerD.isNotEmpty;

  QuestionFormState copyWith({
    String? question,
    String? option,
    String? answerA,
    String? answerB,
    String? answerC,
    String? answerD,
    int? category,
  }) =>
      QuestionFormState(
        question: question ?? this.question,
        option: option ?? this.option,
        answerA: answerA ?? this.answerA,
        answerB: answerB ?? this.answerB,
        answerC: answerC ?? this.answerC,
        answerD: answerD ?? this.answerD,
        category: category ?? this.category,
        questionCtrls: questionCtrls,
        textCtrls: textCtrls,
      );
}

class QuestionFormInitial extends QuestionFormState {
  QuestionFormInitial()
      : super(
            question: "",
            option: "A",
            answerA: "",
            answerB: "",
            answerC: "",
            answerD: "",
            category: 0,
            questionCtrls: TextEditingController(),
            textCtrls: [
              TextEditingController(),
              TextEditingController(),
              TextEditingController(),
              TextEditingController(),
            ]);
}

class ClearQuestionForm extends QuestionFormState {
  ClearQuestionForm()
      : super(
          question: "",
          option: "A",
          answerA: "",
          answerB: "",
          answerC: "",
          answerD: "",
          category: 0,
          questionCtrls: TextEditingController(),
          textCtrls: [
            TextEditingController(),
            TextEditingController(),
            TextEditingController(),
            TextEditingController(),
          ],
        );
}
