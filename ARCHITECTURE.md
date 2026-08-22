# Puzzle App Architecture

## Overview

Puzzle App is a Flutter-based quiz application using the **BLoC (Business Logic Component)** pattern for state management. The architecture is organized into clear layers following clean code principles.

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── blocs/                    # State management layer
│   ├── nameForm/            # Name input BLoC
│   ├── navbar/              # Navigation & stats BLoC
│   ├── play/                # Game logic BLoC
│   ├── setting/             # Settings & configuration BLoC
│   └── questionForm/         # Question creation BLoC
├── pages/                    # UI screens
│   ├── StartPage/           # Initial name input screen
│   ├── MainPage/            # Tab navigation container
│   ├── HomePage/            # Home/stats display
│   ├── PlayPage/            # Quiz game screen
│   ├── SettingPage/         # App settings
│   ├── AddQuestionPage/     # Question creation with tabs (MC/TF/Fill)
│   ├── UserQuestionPage/    # User's custom questions display
│   └── SummaryPage/         # Game results & chart visualization
├── widgets/                  # Reusable UI components
├── models/                   # Data models (Question, etc.)
├── data/                     # Database tables & repositories
│   ├── question_table.dart   # Question persistence layer
│   └── topic_table.dart      # Topic management
└── routes/                   # Navigation configuration
    ├── routes.dart          # Route constants
    └── router.dart          # Route generation logic

assets/
├── images/                   # App images and icons
├── fonts/                    # Custom fonts
└── data/                     # Questions database file
```

## Architecture Layers

### 1. Presentation Layer (UI)

**Location:** `lib/pages/`, `lib/widgets/`

- Contains all Flutter UI screens and reusable widgets
- Communicates with BLoCs via `BlocBuilder`, `BlocListener`, and `BlocProvider`
- Handles user interactions and UI updates

**Key Screens:**
- **StartPage**: Initial player name entry
- **MainPage**: Main app container with bottom navigation
- **HomePage**: Displays player stats and quick play button
- **PlayPage**: Interactive quiz game interface
- **SettingPage**: App configuration (question set, timeout)
- **AddQuestionPage**: Multi-tab interface for adding questions
- **SummaryPage**: Game results with chart visualization

### 2. Business Logic Layer (BLoC)

**Location:** `lib/blocs/`

Responsible for all state management and business logic.

#### **NameFormBloc**
- Handles player name input and validation
- Persists name to SharedPreferences
- Auto-loads saved name on app start

#### **PlayBloc**
- Core game logic: question loading, answer validation
- Manages game state: current question, score, lives, timeout
- Handles countdown timer via `CircularCountdownTimer`
- Supports three question types: multiple choice, true/false, fill-in-the-blank
- Updates persistent stats after each game

#### **NavbarBloc**
- Manages bottom navigation state
- Displays player stats (total played, correct, incorrect)
- Coordinates navigation between tabs

#### **SettingBloc**
- Manages app settings: question set selection, timeout duration
- Persists settings to SharedPreferences
- Supports switching between app questions and custom user questions

#### **QuestionFormBloc**
- Handles custom question creation validation
- Manages form state for three question types
- Saves questions to SQLite database

### 3. Data Layer

**Location:** `lib/data/`, `lib/models/`

#### **Database**
- **Technology:** SQLite (sqflite_common_ffi)
- **Storage:** `assets/data/questions.db` (default app questions)
- **Tables:**
  - `questions`: Stores question data
  - `topics`: Organizes questions by topic

#### **Local Storage**
- **Technology:** SharedPreferences
- **Stored Data:**
  - Player name
  - Total questions played
  - Correct/incorrect counts
  - Selected question set
  - Timeout duration setting

#### **Models**
- `Question`: Data model for quiz questions
- Other domain models for type safety

## State Management Flow

### Typical User Journey

```
1. App Start
   └─> NameFormBloc.LoadName() → Check SharedPreferences
       ├─> If name exists → NavigateToMainPage
       └─> If no name → ShowStartPage

2. Main Navigation
   └─> NavbarBloc.HomeTab() → Load player stats from SharedPreferences

3. Play Game
   └─> PlayBloc.LoadQuestions() → Fetch from database
       ├─> Validate answer → Update score
       ├─> Timer expires → Auto-submit
       └─> Game over → Show SummaryPage with chart

4. Settings
   └─> SettingBloc.ChangeQuestionSet() → Persist choice
```

## Key Dependencies

| Package | Purpose | Usage |
|---------|---------|-------|
| `flutter_bloc` | State management | Event-driven BLoC pattern |
| `sqflite_common_ffi` | SQLite database | Question persistence |
| `shared_preferences` | Local key-value storage | App preferences & stats |
| `circular_countdown_timer` | Countdown UI | Game time limit |
| `fl_chart` | Data visualization | Results pie chart |
| `quickalert` | Alert dialogs | Game notifications |
| `group_button` | Button groups | Question type selection |

## Navigation Structure

```
Routes (in routes.dart):
- StartPage: Initial player name entry
- MainPage: Main app with tabs
- HomePage: Stats & quick play
- PlayPage: Game screen
- AddQuestionPage: Question creation
- SettingPage: App configuration
- UserQuestionPage: View custom questions
- SummaryPage: Game results
```

## Platform Support

- **iOS**: Native iOS build (requires Xcode)
- **Android**: APK/App Bundle (requires Android Studio)
- **Windows**: Desktop app (requires Visual Studio Build Tools)
- **macOS**: Desktop app (requires Xcode)

## Common Patterns

### Event-Driven State Updates
```dart
// Emit event
context.read<MyBloc>().add(MyEvent());

// Listen in BLoC
on<MyEvent>((event, emit) => emit(newState));
```

### Accessing Shared Preferences
```dart
final prefs = await SharedPreferences.getInstance();
final value = prefs.getString('key');
```

### Database Queries
```dart
final db = await QuestionTable().database;
final questions = await db.query('questions');
```

## Best Practices

1. **Immutable States**: All state objects use immutable patterns with `copyWith()`
2. **Separation of Concerns**: Business logic in BLoCs, UI in Pages/Widgets
3. **Error Handling**: Proper exception handling in BLoC methods
4. **Type Safety**: Strong typing throughout (no dynamic types)
5. **Single Responsibility**: Each BLoC handles one specific domain

## Performance Considerations

- Questions cached in memory during gameplay
- Settings cached in SharedPreferences (fast access)
- Database queries minimized with proper indexing
- Chart rendering optimized with FL Chart library

## Future Improvements

- [ ] Add remote API integration for question sync
- [ ] Implement offline-first synchronization
- [ ] Add user authentication
- [ ] Add multiplayer/online features
- [ ] Improve chart analytics (performance trends)
