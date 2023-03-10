import 'package:flutter/material.dart';
import 'package:puzzle_app/data/question_table.dart';
import 'package:puzzle_app/models/question.dart';

class UserQuestionPage extends StatelessWidget {
  const UserQuestionPage({super.key});
  String _getAnswer(Question question) {
    if (question.category == "T/F") {
      if (question.answer == "A") {
        return "True";
      }
      return "False";
    }
    if (question.category == "Trắc Nghiệm") {
      switch (question.answer) {
        case "A":
          return question.optionA!;
        case "B":
          return question.optionB!;
        case "C":
          return question.optionC!;
        case "D":
          return question.optionD!;
      }
    }
    return question.answer;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tổng câu hỏi tự thêm"),
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back),
        //   onPressed: () =>
        //       Navigator.of(context).pushReplacementNamed(Routes.mainPage),
        // ),
      ),
      body: FutureBuilder(
        future: QuestionTable.instance.getAllUserQuestion(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                Question question = snapshot.data![index];
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(
                    color: Colors.red,
                    child: const Icon(
                      Icons.delete,
                      color: Colors.black54,
                    ),
                  ),
                  onDismissed: (direction) {
                    QuestionTable.instance.deleteUserQuestion(question.id!);
                  },
                  child: ListTile(
                    leading: Text(
                      "#${index + 1}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    title: Text(question.question),
                    subtitle: Text(_getAnswer(question)),
                  ),
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
