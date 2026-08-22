import 'package:bloc/bloc.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:puzzle_app/data/question_table.dart';
import 'package:puzzle_app/models/question.dart';
import 'package:puzzle_app/routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'play_event.dart';
part 'play_state.dart';

class PlayBloc extends Bloc<PlayEvent, PlayState> {
  late SharedPreferences _prefs;

  PlayBloc() : super(PlayInitial()) {
    on<LoadQuestions>((event, emit) => _loadQuestions(emit));
    on<NextQuestion>((event, emit) => _nextQuestion(emit));
    on<SelectedOption>((event, emit) => _selectedOption(event, emit));
    on<ShowDialog>((event, emit) => emit(state.copyWith(isShow: true)));
    on<HiddenDialog>(
      (event, emit) => emit(
        state.copyWith(
          isShow: false,
          isTimeout: false,
        ),
      ),
    );
    on<FillOptionChanged>(
      (event, emit) => emit(state.copyWith(fillOption: event.fillOption)),
    );
    on<Timeout>((event, emit) => _handleTimeout(emit));
    on<GameOver>((event, emit) => _handleGameOver(event, emit));
  }

  /// Initialize SharedPreferences (call this in initState or when bloc is created)
  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Load questions from database
  Future<void> _loadQuestions(Emitter<PlayState> emit) async {
    final bool isUserQuestionSet = _prefs.getBool("isUserQuestionSet") ?? false;
    final int durationTimeout = _prefs.getInt("durationTimeout") ?? 30;

    final List<Question> questions = isUserQuestionSet
        ? await QuestionTable.instance.getAllUserQuestion()
        : await QuestionTable.instance.getAllQuestion();

    questions.shuffle();

    emit(state.copyWith(
      questions: questions,
      durationTimeout: durationTimeout,
    ));

    // Load first question
    add(NextQuestion());
    emit(state.copyWith(isLoaded: true));
  }

  /// Move to next question or end game
  void _nextQuestion(Emitter<PlayState> emit) {
    if (state.isGameOver) return;

    // Restart countdown timer
    state.countdownCtrl.restart(duration: state.durationTimeout);

    if (state.questions.isEmpty) return;

    final int nextId = state.id + 1;

    // Game over - all questions answered
    if (nextId >= state.questions.length) {
      add(GameOver(
        totalCorrectQuestion: state.totalCorrectQuestion,
        totalIncorrectQuestion: state.totalIncorrectQuestion,
      ));
      return;
    }

    final Question nextQuestion = state.questions[nextId];

    // Handle different question types
    if (nextQuestion.category == "Trắc Nghiệm") {
      final Map<String, String> optionMap = {
        "A": nextQuestion.optionA ?? "",
        "B": nextQuestion.optionB ?? "",
        "C": nextQuestion.optionC ?? "",
        "D": nextQuestion.optionD ?? "",
      };

      final List<String> shuffledOptions = optionMap.values.toList()..shuffle();
      final String correctAnswer = optionMap[nextQuestion.answer] ?? "";

      emit(state.copyWith(
        id: nextId,
        options: shuffledOptions,
        answer: correctAnswer,
        fillOption: "",
      ));
    } else {
      // T/F or Fill-in-the-blank
      state.fillOptionCtrl.clear();
      emit(state.copyWith(
        id: nextId,
        fillOption: "",
      ));
    }
  }

  /// Check selected option and update stats
  Future<void> _selectedOption(
    SelectedOption event,
    Emitter<PlayState> emit,
  ) async {
    state.countdownCtrl.pause();

    final Question currentQuestion = state.currentQuestion;
    final String userOption = event.option;
    bool isCorrect = false;

    // Validate answer based on question type
    switch (currentQuestion.category) {
      case "Trắc Nghiệm":
        isCorrect = userOption == state.answer;
        break;
      case "T/F":
        isCorrect = userOption == currentQuestion.answer;
        break;
      default:
        // Fill-in-the-blank
        isCorrect =
            userOption.toLowerCase() == currentQuestion.answer.toLowerCase();
    }

    // Update stats
    if (isCorrect) {
      await _incrementCorrectCount();
      emit(state.copyWith(
        isCorrect: true,
        isShow: true,
        totalCorrectQuestion: state.totalCorrectQuestion + 1,
      ));
    } else {
      await _incrementIncorrectCount();
      final int newLife = state.life - 1;
      final bool gameOver = newLife <= 0;

      emit(state.copyWith(
        isCorrect: false,
        isShow: true,
        life: newLife,
        isGameOver: gameOver,
        totalIncorrectQuestion: state.totalIncorrectQuestion + 1,
      ));
    }
  }

  /// Handle timeout event
  Future<void> _handleTimeout(Emitter<PlayState> emit) async {
    await _incrementIncorrectCount();
    final int newLife = state.life - 1;
    final bool gameOver = newLife <= 0;

    emit(state.copyWith(
      isTimeout: true,
      isShow: true,
      life: newLife,
      isGameOver: gameOver,
      totalIncorrectQuestion: state.totalIncorrectQuestion + 1,
    ));
  }

  /// Handle game over and navigation
  void _handleGameOver(
    GameOver event,
    Emitter<PlayState> emit,
  ) {
    emit(state.copyWith(isGameOver: true));
  }

  /// Increment correct answer count in SharedPreferences
  Future<void> _incrementCorrectCount() async {
    final int currentCount = _prefs.getInt("totalCorrectQuestion") ?? 0;
    await _prefs.setInt("totalCorrectQuestion", currentCount + 1);
  }

  /// Increment incorrect answer count in SharedPreferences
  Future<void> _incrementIncorrectCount() async {
    final int currentCount = _prefs.getInt("totalIncorrectQuestion") ?? 0;
    await _prefs.setInt("totalIncorrectQuestion", currentCount + 1);
  }
}
