import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'play_event.dart';
part 'play_state.dart';

class PlayBloc extends Bloc<PlayEvent, PlayState> {
  PlayBloc() : super(PlayInitial()) {
    on<SelectedOption>((event, emit) {
      print("selected option: ${event.option}");
      if (event.option != "C") {
        state.minusLife();
        print(state.life);
      } else {
        print("you selected right");
        print(state.life);
      }
    });
    _checkGameOver() {}
  }
}
