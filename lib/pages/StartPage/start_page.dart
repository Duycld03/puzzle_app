import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_app/blocs/nameForm/name_form_bloc.dart';
import 'package:puzzle_app/pages/StartPage/input_name_form.dart';
import 'package:puzzle_app/routes/routes.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NameFormBloc(),
      child: BlocListener<NameFormBloc, NameFormState>(
        listener: (context, state) {
          if (state.hasName) {
            Navigator.of(context).pushReplacementNamed(Routes.mainPage);
          }
        },
        child: Scaffold(
            body: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(color: Colors.amber),
            ),
            const Expanded(
              flex: 1,
              child: InputNameForm(),
            ),
          ],
        )),
      ),
    );
  }
}
