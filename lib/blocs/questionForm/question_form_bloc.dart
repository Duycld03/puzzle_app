import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:puzzle_app/data/database.dart';
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
    on<OptionsChanged>((event, emit) {
      emit(state.copyWith(option: event.option));
    });
    on<CategoryChanged>((event, emit) {
      emit(state.copyWith(categoryID: event.category));
    });
    on<SubmitForm>((event, emit) => _submitForm(emit));
  }
  Future<void> _submitForm(Emitter emit) async {
    if (state.isValid) {
      Question newQuestion = Question(
          question: state.question,
          answer: state.option,
          optionA: state.answerA,
          optionB: state.answerB,
          optionC: state.answerC,
          optionD: state.answerD,
          categoryID: state.categoryID);
      DBProvider.db.newQuestion(newQuestion).then((value) => print(value));
      _clearForm(emit);
    }
    DBProvider.db.getAllQuestion().then((value) => print(value));
  }

  _clearForm(Emitter emit) {
    emit(ClearQuestionForm());
    state.questionCtrls.clear();
    for (var c in state.textCtrls) {
      c.clear();
    }
  }
}
