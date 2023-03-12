import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_app/blocs/play/play_bloc.dart';

class FillOption extends StatelessWidget {
  const FillOption({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayBloc, PlayState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: state.fillOptionCtrl,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Nhập đáp án đúng nhất",
              ),
              onChanged: (value) => context
                  .read<PlayBloc>()
                  .add(FillOptionChanged(fillOption: value)),
            ),
            const Padding(padding: EdgeInsets.only(top: 20)),
            ElevatedButton(
              onPressed: () {
                if (state.isValid) {
                  context
                      .read<PlayBloc>()
                      .add(SelectedOption(option: state.fillOption!));
                  return;
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Câu trả lời không được để trống",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ),
                );
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                child: Text("Trả lời"),
              ),
            )
          ],
        );
      },
    );
  }
}
