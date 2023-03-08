import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_app/blocs/navbar/navbar_bloc.dart';
import 'package:puzzle_app/pages/HomePage/info_card.dart';
import 'package:puzzle_app/routes/routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<NavbarBloc>().add(HomeTab());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: BlocBuilder<NavbarBloc, NavbarState>(
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: size.height * 0.23,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.asset(
                            "assets/images/avatar.png",
                            alignment: Alignment.center,
                          )),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 20)),
                    Text(
                      state.name ?? "",
                      style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black45),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 20)),
                    InfoCard(
                        title: "Tổng câu hỏi đã chơi:",
                        amount: state.totalQuestionPlayed),
                    InfoCard(
                        title: "Tổng câu đúng:",
                        amount: state.totalCorrectQuestion),
                    InfoCard(
                        title: "Tổng câu sai:",
                        amount: state.totalIncorrectQuestion),
                  ],
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButton: ElevatedButton(
        child: const Padding(
          padding: EdgeInsets.all(5),
          child: Text("Chơi Ngay"),
        ),
        onPressed: () {
          Navigator.of(context).pushReplacementNamed(Routes.playPage);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
