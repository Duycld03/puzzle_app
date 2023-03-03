import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_app/blocs/questionForm/question_form_bloc.dart';

class FillTab extends StatelessWidget {
  const FillTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<QuestionFormBloc, QuestionFormState>(
          builder: (context, state) {
            return TextFormField(
                controller: state.fillAnswerCtrls,
                decoration: const InputDecoration(
                    labelText: 'Đáp án *', border: OutlineInputBorder()),
                validator: (value) =>
                    value!.isEmpty ? "Vui lòng điền đáp án" : null,
                onChanged: (value) {
                  context
                      .read<QuestionFormBloc>()
                      .add(FillAnswerChanged(fillAnswer: value));
                });
          },
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}
