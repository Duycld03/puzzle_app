import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:puzzle_app/data/question_table.dart';
import 'package:puzzle_app/models/question.dart';

part 'question_form_event.dart';
part 'question_form_state.dart';

class QuestionFormBloc extends Bloc<QuestionFormEvent, QuestionFormState> {
  QuestionFormBloc() : super(QuestionFormInitial()) {
    on<QuestionChanged>(
      (event, emit) => emit(state.copyWith(question: event.question)),
    );
    on<AnswerAChanged>(
      (event, emit) => emit(state.copyWith(answerA: event.answerA)),
    );
    on<AnswerBChanged>(
      (event, emit) => emit(state.copyWith(answerB: event.answerB)),
    );
    on<AnswerCChanged>(
      (event, emit) => emit(state.copyWith(answerC: event.answerC)),
    );
    on<AnswerDChanged>(
      (event, emit) => emit(state.copyWith(answerD: event.answerD)),
    );
    on<OptionChanged>(
      (event, emit) => emit(state.copyWith(option: event.option)),
    );
    on<CategoryChanged>(
      (event, emit) => emit(state.copyWith(category: event.category, option: "A")),
    );
    on<FillAnswerChanged>(
      (event, emit) => emit(state.copyWith(fillAnswer: event.fillAnswer)),
    );
    on<TopicChanged>(
      (event, emit) => emit(state.copyWith(topicID: event.topicID)),
    );
    on<ExplainChanged>(
      (event, emit) => emit(state.copyWith(explain: event.explain)),
    );
    on<SubmitForm>((event, emit) => _submitForm(emit));
    on<ClearForm>((event, emit) => _clearForm(emit));
  }

  /// Submit form and save question to database
  Future<void> _submitForm(Emitter<QuestionFormState> emit) async {
    if (!state.isValid) return;

    emit(state.copyWith(isSubmitting: true));

    try {
      final Question newQuestion = _createQuestion();
      final int result = await QuestionTable.instance.newUserQuestion(newQuestion);

      if (result != 0) {
        emit(state.copyWith(isSubmitting: false, submitError: null));
        add(ClearForm());
      } else {
        emit(state.copyWith(
          isSubmitting: false,
          submitError: "Lỗi khi lưu câu hỏi",
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        isSubmitting: false,
        submitError: e.toString(),
      ));
    }
  }

  /// Create Question object based on category
  Question _createQuestion() {
    switch (state.category) {
      case "Trắc Nghiệm":
        return Question(
          maker: "User",
          question: state.question,
          answer: state.option,
          optionA: state.answerA,
          optionB: state.answerB,
          optionC: state.answerC,
          optionD: state.answerD,
          topicID: state.topicID,
          category: state.category,
          explain: state.explain,
        );
      case "T/F":
        return Question(
          maker: "User",
          question: state.question,
          answer: state.option,
          category: state.category,
          topicID: state.topicID,
          explain: state.explain,
        );
      default:
        // Fill-in-the-blank
        return Question(
          maker: "User",
          question: state.question,
          answer: state.fillAnswer.toLowerCase(),
          category: state.category,
          topicID: state.topicID,
          explain: state.explain,
        );
    }
  }

  /// Clear form and reset to initial state
  void _clearForm(Emitter<QuestionFormState> emit) {
    // Clear all text controllers
    state.questionCtrl.clear();
    state.answerCtrls.forEach((ctrl) => ctrl.clear());
    state.explainCtrl.clear();
    state.fillAnswerCtrl.clear();

    // Emit cleared state
    emit(QuestionFormInitial());
  }
}
