import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'navbar_event.dart';
part 'navbar_state.dart';

class NavbarBloc extends Bloc<NavbarEvent, NavbarState> {
  NavbarBloc() : super(ShowHome()) {
    on<HomeTab>((event, emit) {
      emit(ShowHome());
    });
    on<QuestionTab>((event, emit) {
      emit(ShowQuestion());
    });
    on<SettingTab>((event, emit) {
      emit(ShowSetting());
    });
  }
}
