import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'question_form_event.dart';
part 'question_form_state.dart';

class QuestionFormBloc extends Bloc<QuestionFormEvent, QuestionFormState> {
  QuestionFormBloc() : super(const QuestionFormInitial()) {
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
      emit(state.copyWith(category: event.category));
    });
    on<SubmitForm>((event, emit) => _submitForm(emit));
  }
  Future<void> _submitForm(Emitter emit) async {
    print("submit");
    print(state.question);
    print("lựa chọn đúng là ${state.option}");
    print(state.answerA);
    print(state.answerB);
    print(state.answerC);
    print(state.answerD);
    print(state.category);
  }
}
