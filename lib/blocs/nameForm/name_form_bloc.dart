import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'name_form_event.dart';
part 'name_form_state.dart';

class NameFormBloc extends Bloc<NameFormEvent, NameFormState> {
  static const String _nameKey = "name";
  late SharedPreferences _prefs;

  NameFormBloc() : super(const NameFormInitial()) {
    on<NameChanged>((event, emit) => emit(state.copyWith(name: event.name)));
    on<LoadName>((event, emit) => _loadName(emit));
    on<Start>((event, emit) => _startGame(emit));
  }

  /// Initialize SharedPreferences
  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Load saved name from SharedPreferences
  Future<void> _loadName(Emitter<NameFormState> emit) async {
    final String? savedName = _prefs.getString(_nameKey);
    if (savedName != null && savedName.isNotEmpty) {
      emit(state.copyWith(name: savedName, hasName: true));
    }
  }

  /// Save name and start game
  Future<void> _startGame(Emitter<NameFormState> emit) async {
    if (!state.isValid) return;

    try {
      await _prefs.setString(_nameKey, state.name);
      emit(state.copyWith(hasName: true));
    } catch (e) {
      // Handle error if needed
      emit(state.copyWith(hasName: false));
    }
  }
}
