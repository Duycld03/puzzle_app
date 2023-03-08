import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_app/blocs/questionForm/question_form_bloc.dart';
import 'package:puzzle_app/data/topic_table.dart';
import 'package:puzzle_app/pages/AddQuestionPage/quiz_tab.dart';
import 'package:puzzle_app/pages/AddQuestionPage/fill_tab.dart';
import 'package:puzzle_app/pages/AddQuestionPage/tf_tab.dart';

final List<String> categories = ["Trắc Nghiệm", "T/F", "Điền Từ"];

class AddQuestionPage extends StatelessWidget {
  AddQuestionPage({super.key});
  List<Widget> tabs = [const QuizTab(), const TFTab(), const FillTab()];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuestionFormBloc(),
      child: Scaffold(
        body: BlocBuilder<QuestionFormBloc, QuestionFormState>(
          builder: (context, state) {
            return Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: ListView(
                padding: const EdgeInsets.all(32),
                children: [
                  const Text("Chọn thể loại"),
                  Row(
                      children: categories
                          .map((option) => [
                                Radio<String>(
                                    value: option,
                                    groupValue: state.category,
                                    onChanged: (value) {
                                      context.read<QuestionFormBloc>().add(
                                          CategoryChanged(category: value!));
                                    }),
                                Text(option),
                              ])
                          .expand((w) => w)
                          .toList()),
                  const SizedBox(height: 32),
                  TextFormField(
                      controller: state.questionCtrls,
                      decoration: const InputDecoration(
                          labelText: 'Câu hỏi *', border: OutlineInputBorder()),
                      validator: (value) =>
                          value!.isEmpty ? "Vui lòng điền câu hỏi" : null,
                      onChanged: (value) {
                        context
                            .read<QuestionFormBloc>()
                            .add(QuestionChanged(question: value));
                      }),
                  const SizedBox(height: 32),
                  tabs[state.category == categories[0]
                      ? 0
                      : state.category == categories[1]
                          ? 1
                          : 2],
                  TextFormField(
                      controller: state.explainCtrls,
                      decoration: const InputDecoration(
                          labelText: 'Giải thích (Nếu có)',
                          border: OutlineInputBorder()),
                      validator: (value) {
                        return null;
                      },
                      onChanged: (value) {
                        context
                            .read<QuestionFormBloc>()
                            .add(ExplainChanged(explain: value));
                      }),
                  const SizedBox(height: 32),
                  FutureBuilder(
                    future: TopicTable.instance.getAllTopic(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return DropdownButton(
                          value: state.topicID,
                          isExpanded: true,
                          underline: Container(
                            height: 2,
                            color: Colors.blue,
                          ),
                          items: snapshot.data!
                              .map(
                                (topic) => DropdownMenuItem(
                                  value: topic.id,
                                  child: Text(topic.name),
                                ),
                              )
                              .toList(),
                          onChanged: (topicID) {
                            context
                                .read<QuestionFormBloc>()
                                .add(TopicChanged(topicID: topicID!));
                          },
                        );
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {
                      if (state.isValid) {
                        context
                            .read<QuestionFormBloc>()
                            .add(SubmitForm(context: context));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            dismissDirection: DismissDirection.up,
                            content: Text(
                              "Vui lòng nhập đầy đủ thông tin!",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        );
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "Thêm",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
