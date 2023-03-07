part of 'play_bloc.dart';

class PlayState {
  int? id;
  int life;
  List<Question> questions;
  Question? currentQuestion;
  String? answer;
  bool isGameOver;
  List<String> options;
  String? fillOption;
  TextEditingController fillOptionCtrls;

  bool isLoaded = false;

  PlayState({
    required this.isGameOver,
    required this.life,
    required this.questions,
    required this.isLoaded,
    required this.fillOption,
    required this.options,
    required this.fillOptionCtrls,
    this.currentQuestion,
    this.id,
    this.answer,
  }) {
    if (questions.isNotEmpty) {
      currentQuestion = questions[id ?? 0];
    }
  }

  PlayState copyWith({
    int? id,
    bool? isGameOver,
    int? life,
    List<Question>? questions,
    Question? currentQuestion,
    String? answer,
    List<String>? options,
    bool? isLoaded,
    String? fillOption,
    TextEditingController? fillOptionCtrls,
  }) =>
      PlayState(
        id: id ?? this.id,
        isGameOver: isGameOver ?? this.isGameOver,
        life: life ?? this.life,
        questions: questions ?? this.questions,
        currentQuestion: currentQuestion ?? this.currentQuestion,
        answer: answer ?? this.answer,
        options: options ?? this.options,
        isLoaded: isLoaded ?? this.isLoaded,
        fillOption: fillOption ?? this.fillOption,
        fillOptionCtrls: fillOptionCtrls ?? this.fillOptionCtrls,
      );

  get isValid => fillOption!.isNotEmpty;

  minusLife() {
    life--;
    if (life == 0) {
      isGameOver = true;
    }
  }
}

class PlayInitial extends PlayState {
  PlayInitial()
      : super(
          id: 0,
          isGameOver: false,
          life: 3,
          questions: [],
          options: ["", "", "", ""],
          isLoaded: false,
          fillOption: "",
          fillOptionCtrls: TextEditingController(),
        );
}
