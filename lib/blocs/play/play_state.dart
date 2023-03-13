part of 'play_bloc.dart';

class PlayState {
  int? id;
  int life;
  List<Question> questions;
  Question? currentQuestion;
  String? answer;
  bool isGameOver;
  bool isCorrect;
  bool isShow;
  bool isTimeout;
  List<String> options;
  String? fillOption;
  TextEditingController fillOptionCtrl;
  CountDownController countdownCtrl;
  bool isLoaded = false;
  int durationTimeout;
  int totalCorrectQuestion;
  int totalIncorrectQuestion;

  PlayState({
    required this.isGameOver,
    required this.life,
    required this.questions,
    required this.isLoaded,
    required this.fillOption,
    required this.options,
    required this.fillOptionCtrl,
    required this.isCorrect,
    required this.isShow,
    required this.isTimeout,
    required this.durationTimeout,
    required this.countdownCtrl,
    required this.totalCorrectQuestion,
    required this.totalIncorrectQuestion,
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
    TextEditingController? fillOptionCtrl,
    bool? isCorrect,
    bool? isShow,
    bool? isTimeout,
    int? durationTimeout,
    CountDownController? countdownCtrl,
    int? totalCorrectQuestion,
    int? totalIncorrectQuestion,
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
        fillOptionCtrl: fillOptionCtrl ?? this.fillOptionCtrl,
        isCorrect: isCorrect ?? this.isCorrect,
        isShow: isShow ?? this.isShow,
        isTimeout: isTimeout ?? this.isTimeout,
        durationTimeout: durationTimeout ?? this.durationTimeout,
        countdownCtrl: countdownCtrl ?? this.countdownCtrl,
        totalCorrectQuestion: totalCorrectQuestion ?? this.totalCorrectQuestion,
        totalIncorrectQuestion:
            totalIncorrectQuestion ?? this.totalIncorrectQuestion,
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
          fillOptionCtrl: TextEditingController(),
          isCorrect: true,
          isShow: false,
          isTimeout: false,
          durationTimeout: 30,
          countdownCtrl: CountDownController(),
          totalCorrectQuestion: 0,
          totalIncorrectQuestion: 0,
        );
}
