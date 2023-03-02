import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_app/blocs/questionForm/question_form_bloc.dart';
import 'package:puzzle_app/data/topic_table.dart';

final List<String> options = ["A", "B", "C", "D"];
final List<String> categories = ["Trắc nghiệm", "T/F", "Điền từ"];

class AddQuestionPage extends StatelessWidget {
  const AddQuestionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuestionFormBloc(),
      child: Scaffold(
        body: BlocBuilder<QuestionFormBloc, QuestionFormState>(
          builder: (context, state) {
            return Form(
              // key: _formKey,
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
                                  onChanged: (value) => context
                                      .read<QuestionFormBloc>()
                                      .add(CategoryChanged(category: value!)),
                                ),
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
                  const Text("Lựa chọn đúng"),
                  Row(
                      children: options
                          .map((option) => [
                                Radio<String>(
                                  value: option,
                                  groupValue: state.option,
                                  onChanged: (value) => context
                                      .read<QuestionFormBloc>()
                                      .add(OptionChanged(option: value!)),
                                ),
                                Text(option),
                                const SizedBox(width: 16)
                              ])
                          .expand((w) => w)
                          .toList()),
                  const SizedBox(height: 32),
                  ...options
                      .asMap()
                      .entries
                      .map((entry) => [
                            TextFormField(
                                controller: state.textCtrls[entry.key],
                                decoration: InputDecoration(
                                  labelText: "Lựa chọn ${entry.value}*",
                                  border: const OutlineInputBorder(),
                                ),
                                validator: (v) => v!.isEmpty
                                    ? "Vui lòng điền lựa chọn ${entry.value}"
                                    : null,
                                onChanged: (value) {
                                  switch (entry.key) {
                                    case 0:
                                      context
                                          .read<QuestionFormBloc>()
                                          .add(AnswerAChanged(answerA: value));
                                      break;
                                    case 1:
                                      context
                                          .read<QuestionFormBloc>()
                                          .add(AnswerBChanged(answerB: value));
                                      break;
                                    case 2:
                                      context
                                          .read<QuestionFormBloc>()
                                          .add(AnswerCChanged(answerC: value));
                                      break;
                                    case 3:
                                      context
                                          .read<QuestionFormBloc>()
                                          .add(AnswerDChanged(answerD: value));
                                      break;
                                  }
                                }),
                            const SizedBox(height: 32),
                          ])
                      .expand((w) => w),
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
                        context.read<QuestionFormBloc>().add(SubmitForm());
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
