import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_app/blocs/questionForm/question_form_bloc.dart';

class TFTab extends StatelessWidget {
  const TFTab({
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
              children: [
                Radio<String>(
                  value: "A",
                  groupValue: state.option,
                  onChanged: (value) => context
                      .read<QuestionFormBloc>()
                      .add(OptionChanged(option: value!)),
                ),
                const Text("True"),
                Radio<String>(
                  value: "B",
                  groupValue: state.option,
                  onChanged: (value) => context
                      .read<QuestionFormBloc>()
                      .add(OptionChanged(option: value!)),
                ),
                const Text("False"),
              ],
            ),
            const SizedBox(height: 32),
          ],
        );
      },
    );
  }
}
