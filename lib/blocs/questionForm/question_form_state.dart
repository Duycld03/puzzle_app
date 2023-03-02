part of 'question_form_bloc.dart';

@immutable
class QuestionFormState {
  final TextEditingController questionCtrls;
  final List<TextEditingController> textCtrls;
  final String question;
  final String option;
  final String category;
  final String answerA;
  final String answerB;
  final String answerC;
  final String answerD;
  final int topicID;

  const QuestionFormState({
    required this.question,
    required this.option,
    required this.category,
    required this.answerA,
    required this.answerB,
    required this.answerC,
    required this.answerD,
    required this.topicID,
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
    String? category,
    String? answerA,
    String? answerB,
    String? answerC,
    String? answerD,
    int? topicID,
  }) =>
      QuestionFormState(
        question: question ?? this.question,
        option: option ?? this.option,
        category: category ?? this.category,
        answerA: answerA ?? this.answerA,
        answerB: answerB ?? this.answerB,
        answerC: answerC ?? this.answerC,
        answerD: answerD ?? this.answerD,
        topicID: topicID ?? this.topicID,
        questionCtrls: questionCtrls,
        textCtrls: textCtrls,
      );
}

class QuestionFormInitial extends QuestionFormState {
  QuestionFormInitial()
      : super(
            question: "",
            option: "A",
            category: "Trắc nghiệm",
            answerA: "",
            answerB: "",
            answerC: "",
            answerD: "",
            topicID: 1,
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
          category: "Trắc nghiệm",
          answerA: "",
          answerB: "",
          answerC: "",
          answerD: "",
          topicID: 0,
          questionCtrls: TextEditingController(),
          textCtrls: [
            TextEditingController(),
            TextEditingController(),
            TextEditingController(),
            TextEditingController(),
          ],
        );
}
