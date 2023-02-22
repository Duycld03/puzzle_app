import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_app/blocs/navbar/navbar_bloc.dart';
import 'package:puzzle_app/pages/AddQuestionPage/add_question_page.dart';
import 'package:puzzle_app/pages/HomePage/Home_page.dart';
import 'package:puzzle_app/pages/SettingPage/setting_page.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});
  final List<Widget> tabs = [
    AddQuestionPage(),
    const HomePage(),
    const SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavbarBloc(),
      child: BlocBuilder<NavbarBloc, NavbarState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(state.title),
            ),
            body: tabs[state.itemIndex],
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.shifting,
              currentIndex: state.itemIndex,
              items: const [
                BottomNavigationBarItem(
                    label: "Câu hỏi",
                    icon: Icon(Icons.question_answer),
                    backgroundColor: Colors.red),
                BottomNavigationBarItem(
                    label: "Trang chủ",
                    icon: Icon(Icons.home),
                    backgroundColor: Colors.blue),
                BottomNavigationBarItem(
                    label: "Cài đặt",
                    icon: Icon(Icons.settings),
                    backgroundColor: Colors.green),
              ],
              onTap: (value) {
                switch (value) {
                  case 0:
                    context.read<NavbarBloc>().add(QuestionTab());
                    break;
                  case 1:
                    context.read<NavbarBloc>().add(HomeTab());
                    break;
                  case 2:
                    context.read<NavbarBloc>().add(SettingTab());
                    break;
                }
              },
            ),
          );
        },
      ),
    );
  }
}
