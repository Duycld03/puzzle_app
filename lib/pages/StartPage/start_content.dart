import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_app/blocs/nameForm/name_form_bloc.dart';
import 'package:puzzle_app/pages/StartPage/input_name_form.dart';

class StartContent extends StatefulWidget {
  const StartContent({
    Key? key,
  }) : super(key: key);

  @override
  State<StartContent> createState() => _StartContentState();
}

class _StartContentState extends State<StartContent> {
  Future<int> _delay() async {
    await Future.delayed(const Duration(seconds: 1));
    return 0;
  }

  @override
  void initState() {
    context.read<NameFormBloc>().add(Load());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _delay(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
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
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
