part of 'question_form_bloc.dart';

@immutable
class QuestionFormState {
  final TextEditingController questionCtrls;
  final List<TextEditingController> textCtrls;
  final TextEditingController explainCtrls;
  final TextEditingController fillAnswerCtrls;
  final String question;
  final String option;
  final String fillAnswer;
  final String category;
  final String answerA;
  final String answerB;
  final String answerC;
  final String answerD;
  final String? explain;
  final int topicID;

  const QuestionFormState({
    required this.question,
    required this.option,
    required this.fillAnswer,
    required this.category,
    required this.answerA,
    required this.answerB,
    required this.answerC,
    required this.answerD,
    required this.topicID,
    this.explain,
    required this.questionCtrls,
    required this.textCtrls,
    required this.explainCtrls,
    required this.fillAnswerCtrls,
  });

  bool get isValid {
    print("valid...");
    if (category == "Trắc Nghiệm") {
      return question.isNotEmpty &&
          option.isNotEmpty &&
          answerA.isNotEmpty &&
          answerB.isNotEmpty &&
          answerC.isNotEmpty &&
          answerD.isNotEmpty;
    }
    if (category == "T/F") {
      return question.isNotEmpty && option.isNotEmpty;
    }
    return question.isNotEmpty && fillAnswer.isNotEmpty;
  }

  QuestionFormState copyWith({
    String? question,
    String? option,
    String? fillAnswer,
    String? category,
    String? answerA,
    String? answerB,
    String? answerC,
    String? answerD,
    int? topicID,
    String? explain,
  }) =>
      QuestionFormState(
        question: question ?? this.question,
        option: option ?? this.option,
        fillAnswer: fillAnswer ?? this.fillAnswer,
        category: category ?? this.category,
        answerA: answerA ?? this.answerA,
        answerB: answerB ?? this.answerB,
        answerC: answerC ?? this.answerC,
        answerD: answerD ?? this.answerD,
        topicID: topicID ?? this.topicID,
        explain: explain ?? this.explain,
        questionCtrls: questionCtrls,
        textCtrls: textCtrls,
        explainCtrls: explainCtrls,
        fillAnswerCtrls: fillAnswerCtrls,
      );
}

class QuestionFormInitial extends QuestionFormState {
  QuestionFormInitial()
      : super(
          question: "",
          option: "A",
          fillAnswer: "",
          category: "Trắc Nghiệm",
          answerA: "",
          answerB: "",
          answerC: "",
          answerD: "",
          topicID: 1,
          explain: "",
          questionCtrls: TextEditingController(),
          textCtrls: [
            TextEditingController(),
            TextEditingController(),
            TextEditingController(),
            TextEditingController(),
          ],
          explainCtrls: TextEditingController(),
          fillAnswerCtrls: TextEditingController(),
        );
}

class ClearQuestionForm extends QuestionFormState {
  @override
  final String category;
  ClearQuestionForm({required this.category})
      : super(
          question: "",
          option: "A",
          fillAnswer: "",
          category: category,
          answerA: "",
          answerB: "",
          answerC: "",
          answerD: "",
          topicID: 1,
          explain: "",
          questionCtrls: TextEditingController(),
          textCtrls: [
            TextEditingController(),
            TextEditingController(),
            TextEditingController(),
            TextEditingController(),
          ],
          explainCtrls: TextEditingController(),
          fillAnswerCtrls: TextEditingController(),
        );
}
