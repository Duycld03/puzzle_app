part of 'play_bloc.dart';

class PlayState {
  int? id;
  int life;
  List<Question> questions;
  Question? currentQuestion;
  String? answer;
  bool isGameOver;
  List<String> options;

  PlayState({
    required this.isGameOver,
    required this.life,
    required this.questions,
    this.currentQuestion,
    this.id,
    required this.options,
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
  }) =>
      PlayState(
        id: id ?? this.id,
        isGameOver: isGameOver ?? this.isGameOver,
        life: life ?? this.life,
        questions: questions ?? this.questions,
        currentQuestion: currentQuestion ?? this.currentQuestion,
        answer: answer ?? this.answer,
        options: options ?? this.options,
      );
  // Future<int> delay() async {
  //   await Future.delayed(const Duration(milliseconds: 200));
  //   return 0;
  // }

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
        );
}

// class NextQuestion extends PlayState {
//   NextQuestion()
//       : super(
//           isGameOver: false,
//           life: 3,
//           questions: [],
//         );
// }

// class QuestionLoaded extends PlayState {}
