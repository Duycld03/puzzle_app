import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_app/blocs/nameForm/name_form_bloc.dart';
import 'package:puzzle_app/values/app_colors.dart';

class InputNameForm extends StatelessWidget {
  const InputNameForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: BlocBuilder<NameFormBloc, NameFormState>(
              builder: (context, state) {
                return TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: "Enter a Nickname",
                    hintStyle: TextStyle(
                      color: AppColors.hintText,
                    ),
                    errorStyle:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.2,
                    // color: AppColors.primary,
                  ),
                  textAlign: TextAlign.center,
                  validator: (value) =>
                      value!.isEmpty ? "Vui lòng nhập tên" : null,
                  onChanged: (value) => context
                      .read<NameFormBloc>()
                      .add(NameChanged(name: value)),
                );
              },
            ),
          ),
          Padding(padding: EdgeInsets.only(top: size.height * 0.05)),
          BlocBuilder<NameFormBloc, NameFormState>(
            builder: (context, state) {
              return ElevatedButton(
                onPressed: () {
                  if (state.isValid) {
                    context.read<NameFormBloc>().add(Start());
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  width: double.infinity,
                  child: const Text(
                    "START",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
