import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_app/blocs/navbar/navbar_bloc.dart';
import 'package:puzzle_app/pages/AddQuestionPage/add_question_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text("Home Page"),
    );
  }
}
