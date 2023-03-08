part of 'navbar_bloc.dart';

@immutable
class NavbarState {
  final String title;
  final int itemIndex;
  final String? name;
  final int totalQuestionPlayed;
  final int totalCorrectQuestion;
  final int totalIncorrectQuestion;
  const NavbarState({
    required this.title,
    required this.itemIndex,
    required this.totalQuestionPlayed,
    required this.totalCorrectQuestion,
    required this.totalIncorrectQuestion,
    this.name,
  });
  NavbarState copyWith({
    String? title,
    int? itemIndex,
    String? name,
    int? totalQuestionPlayed,
    int? totalCorrectQuestion,
    int? totalIncorrectQuestion,
  }) =>
      NavbarState(
        title: title ?? this.title,
        itemIndex: itemIndex ?? this.itemIndex,
        name: name ?? this.name,
        totalQuestionPlayed: totalQuestionPlayed ?? this.totalQuestionPlayed,
        totalCorrectQuestion: totalCorrectQuestion ?? this.totalCorrectQuestion,
        totalIncorrectQuestion:
            totalIncorrectQuestion ?? this.totalIncorrectQuestion,
      );
}

class NavbarInitial extends NavbarState {
  const NavbarInitial()
      : super(
          title: "Trang chủ",
          itemIndex: 1,
          name: "",
          totalQuestionPlayed: 0,
          totalCorrectQuestion: 0,
          totalIncorrectQuestion: 0,
        );
}
