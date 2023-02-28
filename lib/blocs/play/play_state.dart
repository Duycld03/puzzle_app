part of 'play_bloc.dart';

class PlayState {
  int life;
  final String question;
  final List<String> options;
  final String answer;
  final String? explain;
  final int topicID;
  final int categoryID;
  PlayState({
    required this.life,
    required this.question,
    required this.options,
    required this.answer,
    this.explain,
    required this.topicID,
    required this.categoryID,
  });
  PlayState copyWith({
    int? life,
    String? question,
    List<String>? options,
    String? answer,
    String? explain,
    int? topicID,
    int? categoryID,
  }) =>
      PlayState(
        life: life ?? this.life,
        question: question ?? this.question,
        options: options ?? this.options,
        answer: answer ?? this.answer,
        explain: explain ?? this.explain,
        topicID: topicID ?? this.topicID,
        categoryID: categoryID ?? this.categoryID,
      );

  minusLife() {
    life--;
    if (life == 0) {
      print("Game Over");
    }
  }
}

class PlayInitial extends PlayState {
  PlayInitial()
      : super(
          life: 3,
          question: "",
          options: [],
          answer: "",
          explain: "",
          topicID: 0,
          categoryID: 0,
        );
}

class NextQuestion extends PlayState {
  NextQuestion()
      : super(
          life: 3,
          question: "",
          options: [],
          answer: "",
          explain: "",
          topicID: 0,
          categoryID: 0,
        );
}
