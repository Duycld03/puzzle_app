# Development Guide for Puzzle App

This guide covers everything you need to know for developing and debugging Puzzle App.

## Table of Contents

- [Quick Start](#quick-start)
- [Project Structure](#project-structure)
- [Working with BLoCs](#working-with-blocs)
- [Database Management](#database-management)
- [Debugging](#debugging)
- [Testing](#testing)
- [Common Issues & Solutions](#common-issues--solutions)

## Quick Start

### 1. Clone and Setup

```bash
git clone https://github.com/Duycld03/puzzle_app.git
cd puzzle_app
flutter pub get
flutter pub run flutter_launcher_icons:main
```

### 2. Run the App

```bash
# Check available devices
flutter devices

# Run on specific device
flutter run -d <device_id>

# Run with verbose output
flutter run -v

# Run in profile mode (better performance)
flutter run --profile
```

### 3. Build for Release

```bash
# Android
flutter build apk --release
flutter build appbundle --release

# iOS
flutter build ios --release

# Windows
flutter build windows --release
```

## Project Structure Deep Dive

### BLoC Directory Structure

Each BLoC has three files:

```
lib/blocs/myfeature/
├── my_feature_bloc.dart    # Main BLoC class
├── my_feature_event.dart   # Events (triggered by UI)
└── my_feature_state.dart   # States (emitted by BLoC)
```

### File Dependencies

```dart
// In my_feature_bloc.dart
part 'my_feature_event.dart';  // ✓ Must be here
part 'my_feature_state.dart';  // ✓ Must be here

class MyFeatureBloc extends Bloc<MyFeatureEvent, MyFeatureState> { ... }
```

## Working with BLoCs

### Creating a New BLoC

#### Step 1: Create the Event File

```dart
// lib/blocs/myfeature/my_feature_event.dart
part of 'my_feature_bloc.dart';

abstract class MyFeatureEvent extends Equatable {
  const MyFeatureEvent();

  @override
  List<Object> get props => [];
}

class MyEvent extends MyFeatureEvent {
  final String data;

  const MyEvent({required this.data});

  @override
  List<Object> get props => [data];
}
```

#### Step 2: Create the State File

```dart
// lib/blocs/myfeature/my_feature_state.dart
part of 'my_feature_bloc.dart';

@immutable
class MyFeatureState {
  final String result;
  final bool isLoading;

  const MyFeatureState({
    required this.result,
    required this.isLoading,
  });

  MyFeatureState copyWith({
    String? result,
    bool? isLoading,
  }) =>
    MyFeatureState(
      result: result ?? this.result,
      isLoading: isLoading ?? this.isLoading,
    );
}

class MyFeatureInitial extends MyFeatureState {
  const MyFeatureInitial()
      : super(
          result: '',
          isLoading: false,
        );
}
```

#### Step 3: Create the BLoC File

```dart
// lib/blocs/myfeature/my_feature_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'my_feature_event.dart';
part 'my_feature_state.dart';

class MyFeatureBloc extends Bloc<MyFeatureEvent, MyFeatureState> {
  MyFeatureBloc() : super(const MyFeatureInitial()) {
    on<MyEvent>((event, emit) => _onMyEvent(event, emit));
  }

  Future<void> _onMyEvent(
    MyEvent event,
    Emitter<MyFeatureState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      // Do work here
      emit(state.copyWith(
        result: 'Success',
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        result: 'Error: $e',
        isLoading: false,
      ));
    }
  }
}
```

### Using BLoC in UI

#### Creating a BLoC

```dart
BlocProvider(
  create: (context) => MyFeatureBloc(),
  child: MyWidget(),
)
```

#### Listening to State Changes

```dart
BlocListener<MyFeatureBloc, MyFeatureState>(
  listener: (context, state) {
    if (state.isLoading) {
      // Show loading indicator
    }
    if (state.result.isNotEmpty) {
      // Show result
    }
  },
  child: widget,
)
```

#### Building UI from State

```dart
BlocBuilder<MyFeatureBloc, MyFeatureState>(
  builder: (context, state) {
    if (state.isLoading) {
      return const CircularProgressIndicator();
    }
    return Text(state.result);
  },
)
```

#### Accessing BLoC and Adding Events

```dart
// Read BLoC (one-time access)
context.read<MyFeatureBloc>().add(MyEvent(data: 'test'));

// In BlocBuilder (watch for changes)
context.watch<MyFeatureBloc>().result;
```

## Database Management

### Understanding SQLite in Puzzle App

The app uses SQLite for persistent question storage.

### Database Location

- **Default questions:** `assets/data/questions.db`
- **Runtime location:** Platform-specific (handled by sqflite_common_ffi)

### Database Operations

```dart
// In lib/data/question_table.dart
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class QuestionTable {
  static const String tableName = 'questions';
  
  Future<List<Question>> getAllQuestions() async {
    final db = await database;  // Get database instance
    final maps = await db.query(tableName);
    return List.generate(maps.length, (i) => Question.fromJson(maps[i]));
  }
  
  Future<int> insertQuestion(Question question) async {
    final db = await database;
    return await db.insert(tableName, question.toJson());
  }
  
  Future<void> deleteQuestion(int id) async {
    final db = await database;
    await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }
}
```

### Resetting Database

```bash
# Delete app data (clears all SharedPreferences and databases)
flutter run --purge-persistent-cache

# Or manually in code:
Final prefs = await SharedPreferences.getInstance();
await prefs.clear();
```

## Debugging

### Enable Verbose Logging

```bash
flutter run -v  # Shows all debug output
```

### Print Debugging

```dart
print('Debug: $value');  // Simple print
debugPrint('Object: $object');  // For large objects
```

### BLoC Logging

```dart
// Add to BLoC for event tracking
on<MyEvent>((event, emit) {
  debugPrint('Event: $event');
  debugPrint('Old state: $state');
  // ... handle event
  debugPrint('New state: $state');
});
```

### Flutter DevTools

```bash
# Start DevTools
flutter pub global activate devtools
devtools

# Or integrated with Flutter
flutter run
# Then press 'd' to open DevTools
```

**Available in DevTools:**
- Inspector: Widget tree inspection
- Performance: Frame timing and jank detection
- Memory: Memory allocation tracking
- Network: HTTP requests
- Logging: App logs

### Common Debug Tips

```dart
// Check SharedPreferences
Final prefs = await SharedPreferences.getInstance();
debugPrint('Name: ${prefs.getString('name')}');
debugPrint('All keys: ${prefs.getKeys()}');

// Check BLoC state
print(context.read<MyBloc>().state);

// Hot reload (without losing state)
// Press 'r' in terminal during flutter run

// Hot restart (resets app state)
// Press 'R' in terminal during flutter run
```

## Testing

### Running Tests

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/blocs/play_bloc_test.dart

# Run with coverage
flutter test --coverage
```

### Writing Unit Tests for BLoCs

```dart
// test/blocs/my_feature_bloc_test.dart
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:puzzle_app/blocs/myfeature/my_feature_bloc.dart';

void main() {
  group('MyFeatureBloc', () {
    late MyFeatureBloc myFeatureBloc;

    setUp(() {
      myFeatureBloc = MyFeatureBloc();
    });

    tearDown(() {
      myFeatureBloc.close();
    });

    test('initial state is MyFeatureInitial', () {
      expect(myFeatureBloc.state, isA<MyFeatureInitial>());
    });

    blocTest<MyFeatureBloc, MyFeatureState>(
      'emits [MyFeatureState] when MyEvent is added',
      build: () => myFeatureBloc,
      act: (bloc) => bloc.add(MyEvent(data: 'test')),
      expect: () => [
        isA<MyFeatureState>()
            .having((state) => state.result, 'result', 'Success')
            .having((state) => state.isLoading, 'isLoading', false),
      ],
    );
  });
}
```

## Common Issues & Solutions

### Issue: "Unhandled Exception: DatabaseException"

**Cause:** Database not initialized or path invalid

**Solution:**
```dart
// Ensure database is initialized in QuestionTable
final db = await _getDatabase();
if (db == null) throw Exception('Database not initialized');
```

### Issue: BLoC state not updating UI

**Cause:** Not using `BlocBuilder` or state reference is same object

**Solution:**
```dart
// ✓ Correct: Use copyWith to create new state
emit(state.copyWith(value: newValue));

// ✗ Wrong: Mutating existing state
state.value = newValue;
emit(state);
```

### Issue: Hot reload not working

**Cause:** Changes in BLoC listeners or event handlers

**Solution:**
```bash
# Use hot restart instead
# Press 'R' in terminal (not 'r')
```

### Issue: SharedPreferences returns null unexpectedly

**Cause:** Not awaiting initialization or wrong key

**Solution:**
```dart
// ✓ Always await
final prefs = await SharedPreferences.getInstance();
final value = prefs.getString('exact_key_name');

// ✓ Check if key exists
if (prefs.containsKey('key')) { ... }
```

### Issue: Timer not stopping when leaving page

**Cause:** Timer not disposed properly

**Solution:**
```dart
// Dispose timer in BLoC close method
@override
Future<void> close() {
  _countdownTimer?.cancel();
  return super.close();
}
```

## Performance Optimization

### Profile Mode

```bash
# Run in profile mode for realistic performance
flutter run --profile

# Build release APK
flutter build apk --release
```

### Check Performance

```dart
// Measure execution time
final stopwatch = Stopwatch()..start();
// ... code to measure ...
debugPrint('Elapsed: ${stopwatch.elapsedMilliseconds}ms');
```

### Optimize Builds

```bash
# Check build size
flutter build apk --release --analyze-size

# Split APKs by ABI (reduces size)
flutter build appbundle --release
```

## Resources

- [Flutter Documentation](https://docs.flutter.dev)
- [BLoC Library](https://bloclibrary.dev)
- [Dart Documentation](https://dart.dev)
- [SQLite Flutter Guide](https://pub.dev/packages/sqflite)
- [Flutter DevTools](https://docs.flutter.dev/development/tools/devtools)

---

For more detailed architecture information, see [ARCHITECTURE.md](ARCHITECTURE.md)
