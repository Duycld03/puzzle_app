import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:puzzle_app/data/question_table.dart';
import 'package:puzzle_app/models/question.dart';

part 'question_form_event.dart';
part 'question_form_state.dart';

class QuestionFormBloc extends Bloc<QuestionFormEvent, QuestionFormState> {
  QuestionFormBloc() : super(QuestionFormInitial()) {
    on<QuestionChanged>((event, emit) {
      emit(state.copyWith(question: event.question));
    });

    on<AnswerAChanged>((event, emit) {
      emit(state.copyWith(answerA: event.answerA));
    });

    on<AnswerBChanged>((event, emit) {
      emit(state.copyWith(answerB: event.answerB));
    });

    on<AnswerCChanged>((event, emit) {
      emit(state.copyWith(answerC: event.answerC));
    });

    on<AnswerDChanged>((event, emit) {
      emit(state.copyWith(answerD: event.answerD));
    });

    on<OptionChanged>((event, emit) {
      emit(state.copyWith(option: event.option));
    });

    on<CategoryChanged>((event, emit) {
      emit(state.copyWith(category: event.category, option: "A"));
    });

    on<FillAnswerChanged>((event, emit) {
      emit(state.copyWith(fillAnswer: event.fillAnswer));
    });

    on<TopicChanged>((event, emit) {
      emit(state.copyWith(topicID: event.topicID));
    });

    on<ExplainChanged>(((event, emit) {
      emit(state.copyWith(explain: event.explain));
    }));

    on<SubmitForm>((event, emit) => _submitForm(emit));
  }
  Future<void> _submitForm(Emitter emit) async {
    if (state.isValid) {
      late Question newQuestion;
      if (state.category == "Trắc nghiệm") {
        newQuestion = Question(
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
      } else if (state.category == "T/F") {
        newQuestion = Question(
          maker: "User",
          question: state.question,
          answer: state.option,
          category: state.category,
          topicID: state.topicID,
          explain: state.explain,
        );
      } else {
        newQuestion = Question(
          maker: "User",
          question: state.question,
          answer: state.fillAnswer,
          category: state.category,
          topicID: state.topicID,
          explain: state.explain,
        );
      }
      QuestionTable.instance
          .newUserQuestion(newQuestion)
          .then((value) => print(value));
      _clearForm(emit);
    }
    QuestionTable.instance.getAllUserQuestion().then((value) => print(value));
    print(state);
    _clearForm(emit);
  }

  _clearForm(Emitter emit) {
    emit(ClearQuestionForm(category: state.category));
    state.questionCtrls.clear();
    state.fillAnswerCtrls.clear();
    state.explainCtrls.clear();
    for (var c in state.textCtrls) {
      c.clear();
    }
  }
}
