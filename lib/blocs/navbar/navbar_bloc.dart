import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'navbar_event.dart';
part 'navbar_state.dart';

class NavbarBloc extends Bloc<NavbarEvent, NavbarState> {
  NavbarBloc() : super(const NavbarInitial()) {
    on<HomeTab>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      final String? name = prefs.getString("name");
      final int totalCorrectQuestion =
          prefs.getInt("totalCorrectQuestion") ?? 0;
      final int totalIncorrectQuestion =
          prefs.getInt("totalIncorrectQuestion") ?? 0;
      final int totalQuestionPlayed =
          totalCorrectQuestion + totalIncorrectQuestion;
      emit(
        state.copyWith(
          title: "Trang chủ",
          itemIndex: 1,
          name: name,
          totalQuestionPlayed: totalQuestionPlayed,
          totalCorrectQuestion: totalCorrectQuestion,
          totalIncorrectQuestion: totalIncorrectQuestion,
        ),
      );
    });
    on<QuestionTab>((event, emit) {
      emit(state.copyWith(title: "Thêm câu hỏi", itemIndex: 0));
    });
    on<SettingTab>((event, emit) {
      emit(state.copyWith(title: "Cài đặt", itemIndex: 2));
    });
  }
}
