import 'package:flutter/material.dart';
import 'package:puzzle_app/pages/AddQuestionPage/add_question_page.dart';
import 'package:puzzle_app/pages/HomePage/Home_page.dart';
import 'package:puzzle_app/pages/StartPage/start_page.dart';

class Router {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "HomePage":
        return MaterialPageRoute(builder: (context) => const HomePage());
      case "StartPage":
        return MaterialPageRoute(builder: (context) => const StartPage());
      case "AddQuestionPage":
        return MaterialPageRoute(builder: (context) => AddQuestionPage());
      default:
        return MaterialPageRoute(
          builder: (context) => Center(
            child: Text("No route defined for ${settings.name}"),
          ),
        );
    }
  }
}
