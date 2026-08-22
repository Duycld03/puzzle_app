part of 'play_bloc.dart';

class PlayState {
  final int id;
  final int life;
  final List<Question> questions;
  final Question? currentQuestion;
  final String? answer;
  final bool isGameOver;
  final bool isCorrect;
  final bool isShow;
  final bool isTimeout;
  final List<String> options;
  final String fillOption;
  final TextEditingController fillOptionCtrl;
  final CountDownController countdownCtrl;
  final bool isLoaded;
  final int durationTimeout;
  final int totalCorrectQuestion;
  final int totalIncorrectQuestion;

  PlayState({
    required this.id,
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
    this.answer,
  });

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
  }) {
    final newId = id ?? this.id;
    final newLife = life ?? this.life;
    final newIsGameOver = isGameOver ?? this.isGameOver;
    final newQuestions = questions ?? this.questions;
    final newCurrentQuestion = currentQuestion ?? (newQuestions.isEmpty ? null : newQuestions[newId]);

    return PlayState(
      id: newId,
      isGameOver: newIsGameOver,
      life: newLife,
      questions: newQuestions,
      currentQuestion: newCurrentQuestion,
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
      totalIncorrectQuestion: totalIncorrectQuestion ?? this.totalIncorrectQuestion,
    );
  }

  bool get isValid => fillOption.isNotEmpty;
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
