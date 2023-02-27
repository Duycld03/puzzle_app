import "package:flutter/material.dart";
import 'package:puzzle_app/pages/HomePage/info_card.dart';
import 'package:puzzle_app/routes/routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
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
                const Text(
                  "Nick Name",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black45),
                ),
                const Padding(padding: EdgeInsets.only(top: 20)),
                const InfoCard(title: "Tổng câu hỏi đã chơi:", amount: 0),
                const InfoCard(title: "Tổng câu đúng:", amount: 0),
                const InfoCard(title: "Tổng câu sai:", amount: 0),
              ],
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
          Navigator.of(context).pushNamed(Routes.playPage);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
