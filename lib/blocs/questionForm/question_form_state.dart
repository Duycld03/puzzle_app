part of 'question_form_bloc.dart';

@immutable
class QuestionFormState {
  final TextEditingController questionCtrl;
  final List<TextEditingController> answerCtrls;
  final TextEditingController explainCtrl;
  final TextEditingController fillAnswerCtrl;
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
  final bool isSubmitting;
  final String? submitError;

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
    required this.questionCtrl,
    required this.answerCtrls,
    required this.explainCtrl,
    required this.fillAnswerCtrl,
    this.explain,
    this.isSubmitting = false,
    this.submitError,
  });

  /// Validate form based on category
  bool get isValid {
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
    bool? isSubmitting,
    String? submitError,
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
        questionCtrl: questionCtrl,
        answerCtrls: answerCtrls,
        explainCtrl: explainCtrl,
        fillAnswerCtrl: fillAnswerCtrl,
        isSubmitting: isSubmitting ?? this.isSubmitting,
        submitError: submitError ?? this.submitError,
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
          questionCtrl: TextEditingController(),
          answerCtrls: [
            TextEditingController(),
            TextEditingController(),
            TextEditingController(),
            TextEditingController(),
          ],
          explainCtrl: TextEditingController(),
          fillAnswerCtrl: TextEditingController(),
        );
}
