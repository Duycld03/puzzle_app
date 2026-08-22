# Puzzle App 🎯

A Flutter-based quiz application with beautiful UI, local database storage, and real-time score tracking.

## Features ✨

- 📱 Cross-platform support (iOS, Android, Windows, macOS)
- 🎨 Modern and intuitive user interface
- 💾 Local SQLite database for offline functionality
- ⏱️ Countdown timer for timed quizzes
- 📊 Real-time score tracking and statistics
- 🎯 Multiple quiz categories and questions
- 💾 Persistent data storage with shared_preferences
- 📈 Chart visualization for performance tracking

## Technologies Used 🛠️

- **Language**: Dart
- **Framework**: Flutter
- **State Management**: BLoC (flutter_bloc)
- **Database**: SQLite (sqflite_common_ffi)
- **UI Components**:
  - Cupertino Icons
  - QuickAlert
  - Circular Countdown Timer
  - Group Button
  - FL Chart

## Project Structure 📁

```
puzzle_app/
├── lib/
│   ├── main.dart
│   ├── screens/
│   ├── models/
│   ├── blocs/
│   └── widgets/
├── assets/
│   ├── images/
│   ├── fonts/
│   └── data/
├── ios/
├── android/
├── windows/
└── pubspec.yaml
```

## Getting Started 🚀

### Prerequisites

- Flutter SDK (>=2.18.6, <3.0.0)
- Dart SDK
- Xcode (for iOS development)
- Android Studio (for Android development)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/Duycld03/puzzle_app.git
   cd puzzle_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate app icons**
   ```bash
   flutter pub run flutter_launcher_icons:main
   ```

4. **Run the application**
   ```bash
   flutter run
   ```

### Building for Different Platforms

**iOS:**
```bash
flutter build ios
```

**Android:**
```bash
flutter build apk
# or for App Bundle
flutter build appbundle
```

**Windows:**
```bash
flutter build windows
```

## Dependencies 📦

| Package | Version | Purpose |
|---------|---------|---------|
| flutter_bloc | ^8.1.2 | State management |
| shared_preferences | ^2.0.18 | Local preferences storage |
| sqflite_common_ffi | ^2.2.1+1 | SQLite database |
| circular_countdown_timer | ^0.2.3 | Countdown UI |
| group_button | ^5.2.2 | Button group UI |
| fl_chart | ^0.61.0 | Chart visualization |
| quickalert | ^1.0.1 | Alert dialogs |

See `pubspec.yaml` for complete dependency list.

## Contributing 🤝

Contributions are welcome! Please feel free to submit a Pull Request.

## License 📄

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Author 👤

**Duycld03**
- GitHub: [@Duycld03](https://github.com/Duycld03)

## Support 💬

If you have any questions or issues, please open an issue on the GitHub repository.

---

Made with ❤️ by Duycld03
