# Contributing to Puzzle App

Thank you for your interest in contributing to Puzzle App! This document provides guidelines and instructions for contributing to the project.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Setup](#development-setup)
- [Making Changes](#making-changes)
- [Commit Guidelines](#commit-guidelines)
- [Pull Request Process](#pull-request-process)
- [Code Style Guide](#code-style-guide)
- [Reporting Bugs](#reporting-bugs)
- [Suggesting Features](#suggesting-features)

## Code of Conduct

Please be respectful and constructive in all interactions. We aim to maintain a welcoming and inclusive community for all contributors.

## Getting Started

### Prerequisites

- Flutter SDK (>=2.18.6, <3.0.0)
- Dart SDK
- Git
- IDE: Android Studio, IntelliJ IDEA, or VS Code with Flutter extension

### Fork and Clone

1. Fork the repository on GitHub
2. Clone your fork locally:
   ```bash
   git clone https://github.com/YOUR_USERNAME/puzzle_app.git
   cd puzzle_app
   ```

## Development Setup

### 1. Install Dependencies

```bash
flutter pub get
```

### 2. Setup Database

The app uses SQLite for question storage. The default database is included in `assets/data/questions.db`.

To reset the database:
```bash
rm assets/data/questions.db
flutter run  # App will recreate it
```

### 3. Run the App

**For Android:**
```bash
flutter run -d <device_id>  # List devices: flutter devices
```

**For iOS:**
```bash
flutter run -d <device_id>
```

**For Windows/macOS:**
```bash
flutter run -d windows
flutter run -d macos
```

### 4. Generate App Icons

```bash
flutter pub run flutter_launcher_icons:main
```

## Making Changes

### Create a Feature Branch

Always create a new branch for your feature or fix:

```bash
git checkout -b feature/your-feature-name
# or for bug fixes:
git checkout -b fix/bug-description
```

### Branch Naming Conventions

- **Features:** `feature/descriptive-name`
- **Bug Fixes:** `fix/bug-description`
- **Improvements:** `improvement/change-description`
- **Documentation:** `docs/what-documentation`
- **Cleanup:** `cleanup/what-cleanup`

### Code Organization

Follow the existing project structure:

- **New Screens:** Add to `lib/pages/YourScreenName/`
- **New BLoCs:** Add to `lib/blocs/yourbloc/` with event, state, and bloc files
- **Reusable Widgets:** Add to `lib/widgets/`
- **Models:** Add to `lib/models/`
- **Database Operations:** Add to `lib/data/`

## Commit Guidelines

### Commit Message Format

Use clear, descriptive commit messages:

```
<type>: <subject>

<body>

<footer>
```

### Types

- **feat**: A new feature
- **fix**: A bug fix
- **docs**: Documentation changes
- **style**: Code style changes (formatting, semicolons, etc.)
- **refactor**: Code refactoring without feature changes
- **perf**: Performance improvements
- **test**: Adding or updating tests
- **chore**: Build process, dependencies, etc.
- **cleanup**: Code cleanup and dead code removal

### Examples

```
feat: add dark theme support to main page

Implement theme switching using BLoC pattern.
Add theme persistence via SharedPreferences.

Closes #123
```

```
fix: resolve countdown timer reset issue

Fix timer not resetting when moving to next question.
Add proper timer disposal in PlayBloc.
```

## Pull Request Process

### Before Submitting

1. **Update your branch with latest changes:**
   ```bash
   git fetch origin
   git rebase origin/main
   ```

2. **Run tests and linting:**
   ```bash
   flutter analyze
   flutter test
   ```

3. **Format your code:**
   ```bash
   dart format lib/
   ```

4. **Test on multiple platforms:**
   - Test on Android (physical device or emulator)
   - Test on iOS (if possible)
   - Test on Windows/macOS desktop

### PR Description Template

```markdown
## Description
Clear description of what your PR does.

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Related Issues
Closes #(issue number)

## Testing
- [ ] Tested on Android
- [ ] Tested on iOS
- [ ] Tested on Windows/macOS
- [ ] All tests pass

## Screenshots (if applicable)
Add screenshots showing the changes.

## Checklist
- [ ] Code follows style guidelines
- [ ] No new warnings generated
- [ ] Tests added/updated
- [ ] Documentation updated
- [ ] No breaking changes
```

### PR Review Guidelines

- Be open to feedback
- Respond to review comments promptly
- Make requested changes and push new commits
- Re-request review after updates

## Code Style Guide

### Dart/Flutter Standards

1. **Naming Conventions:**
   - Classes: `PascalCase` (e.g., `MyBloc`, `HomePage`)
   - Methods/Functions: `camelCase` (e.g., `loadQuestions()`)
   - Constants: `camelCase` (e.g., `maxAttempts`)
   - Private members: prefix with `_` (e.g., `_prefs`)

2. **File Naming:**
   - `snake_case.dart` (e.g., `home_page.dart`, `play_bloc.dart`)

3. **Imports:**
   ```dart
   // Dart/Flutter imports
   import 'package:flutter/material.dart';
   
   // Package imports
   import 'package:flutter_bloc/flutter_bloc.dart';
   
   // Local imports
   import 'package:puzzle_app/models/question.dart';
   ```

4. **Formatting:**
   ```bash
   dart format lib/  # Auto-format all files
   ```

5. **Linting:**
   ```bash
   flutter analyze   # Check for issues
   ```

### BLoC Pattern

```dart
// File: lib/blocs/example/example_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'example_event.dart';
part 'example_state.dart';

class ExampleBloc extends Bloc<ExampleEvent, ExampleState> {
  ExampleBloc() : super(ExampleInitial()) {
    on<MyEvent>((event, emit) => _onMyEvent(event, emit));
  }

  Future<void> _onMyEvent(MyEvent event, Emitter<ExampleState> emit) async {
    // Handle event
    emit(state.copyWith(property: value));
  }
}
```

### State Classes

```dart
// Always use immutable states with copyWith
class MyState {
  final String property;
  
  const MyState({required this.property});
  
  MyState copyWith({String? property}) =>
    MyState(property: property ?? this.property);
}
```

## Reporting Bugs

### Before Reporting

1. Check if the bug already exists in [Issues](https://github.com/Duycld03/puzzle_app/issues)
2. Update Flutter to the latest version
3. Try reproducing on a clean build

### Creating a Bug Report

Include:

1. **Title:** Clear, descriptive title
2. **Description:** What did you try? What happened? What did you expect?
3. **Steps to Reproduce:**
   ```
   1. Start app
   2. Navigate to...
   3. Click...
   4. Observe...
   ```
4. **Environment:**
   ```
   Flutter version: [output of `flutter --version`]
   Platform: Android/iOS/Windows/macOS
   Device: [model, OS version]
   ```
5. **Logs:**
   ```
   [Paste relevant error messages or logs]
   ```
6. **Screenshots/Videos:** Visual reproduction

## Suggesting Features

### Before Suggesting

1. Check [Issues](https://github.com/Duycld03/puzzle_app/issues) for similar suggestions
2. Consider if the feature aligns with the project goals
3. Think about implementation complexity

### Creating a Feature Request

Include:

1. **Title:** Clear, concise title
2. **Description:** Why is this feature needed?
3. **Proposed Solution:** How should it work?
4. **Alternative Approaches:** Other possible solutions
5. **Screenshots/Mockups:** Visual representation if applicable

## Getting Help

- **Questions:** Create a Discussion on GitHub
- **Issues:** Check existing [Issues](https://github.com/Duycld03/puzzle_app/issues)
- **Documentation:** See [ARCHITECTURE.md](ARCHITECTURE.md) for detailed structure

## License

By contributing to Puzzle App, you agree that your contributions will be licensed under its MIT License.

---

Thank you for contributing to Puzzle App! 🎯
