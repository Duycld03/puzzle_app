import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'navbar_event.dart';
part 'navbar_state.dart';

class NavbarBloc extends Bloc<NavbarEvent, NavbarState> {
  late SharedPreferences _prefs;

  NavbarBloc() : super(const NavbarInitial()) {
    on<HomeTab>((event, emit) => _onHomeTab(emit));
    on<QuestionTab>((event, emit) => emit(
          state.copyWith(title: "Thêm câu hỏi", itemIndex: 0),
        ));
    on<SettingTab>((event, emit) => emit(
          state.copyWith(title: "Cài đặt", itemIndex: 2),
        ));
  }

  /// Initialize SharedPreferences
  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Handle home tab tap
  Future<void> _onHomeTab(Emitter<NavbarState> emit) async {
    final String? name = _prefs.getString("name");
    final int totalCorrectQuestion =
        _prefs.getInt("totalCorrectQuestion") ?? 0;
    final int totalIncorrectQuestion =
        _prefs.getInt("totalIncorrectQuestion") ?? 0;
    final int totalQuestionPlayed =
        totalCorrectQuestion + totalIncorrectQuestion;

    emit(state.copyWith(
      title: "Trang chủ",
      itemIndex: 1,
      name: name,
      totalQuestionPlayed: totalQuestionPlayed,
      totalCorrectQuestion: totalCorrectQuestion,
      totalIncorrectQuestion: totalIncorrectQuestion,
    ));
  }
}
