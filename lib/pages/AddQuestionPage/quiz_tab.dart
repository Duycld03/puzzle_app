import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_app/blocs/questionForm/question_form_bloc.dart';

final List<String> options = ["A", "B", "C", "D"];

class QuizTab extends StatelessWidget {
  const QuizTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionFormBloc, QuestionFormState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
          ],
        );
      },
    );
  }
}
