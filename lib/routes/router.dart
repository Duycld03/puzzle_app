import 'package:flutter/material.dart';
import 'package:puzzle_app/pages/AddQuestionPage/add_question_page.dart';
import 'package:puzzle_app/pages/HomePage/home_page.dart';
import 'package:puzzle_app/pages/MainPage/main_page.dart';
import 'package:puzzle_app/pages/PlayPage/play_page.dart';
import 'package:puzzle_app/pages/SettingPage/setting_page.dart';
import 'package:puzzle_app/pages/StartPage/start_page.dart';

class Router {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "StartPage":
        return MaterialPageRoute(builder: (context) => const StartPage());
      case "MainPage":
        return MaterialPageRoute(builder: (context) => MainPage());
      case "HomePage":
        return MaterialPageRoute(builder: (context) => const HomePage());
      case "AddQuestionPage":
        return MaterialPageRoute(builder: (context) => AddQuestionPage());
      case "PlayPage":
        return MaterialPageRoute(builder: (context) => const PlayPage());
      case "SettingPage":
        return MaterialPageRoute(builder: (context) => const SettingPage());
      default:
        return MaterialPageRoute(
          builder: (context) => Center(
            child: Text("No route defined for ${settings.name}"),
          ),
        );
    }
  }
}
