import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'name_form_event.dart';
part 'name_form_state.dart';

class NameFormBloc extends Bloc<NameFormEvent, NameFormState> {
  NameFormBloc() : super(const NameFormInitial()) {
    on<NameChanged>((event, emit) => emit(state.copyWith(name: event.name)));
    on<LoadName>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      final String? name = prefs.getString("name");
      if (name != null) {
        emit(state.copyWith(hasName: true));
      }
    });
    on<Start>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("name", state.name);
      emit(state.copyWith(hasName: true));
    });
  }
}
