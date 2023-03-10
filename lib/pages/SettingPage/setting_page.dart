import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_app/blocs/setting/setting_bloc.dart';
import 'package:puzzle_app/routes/routes.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  void initState() {
    context.read<SettingBloc>().add(LoadSetting());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SettingBloc, SettingState>(
        builder: (context, state) {
          return Column(
            children: [
              ListTile(
                  title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(state.questionSet),
                  Switch(
                    value: state.isUserQuestionSet,
                    onChanged: (value) {
                      context
                          .read<SettingBloc>()
                          .add(ChangeQuestionSet(isUserQuestionSet: value));
                      if (!state.isValid) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                                content: Text(
                          "Bộ câu hỏi tự thêm đang trống",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        )));
                      }
                    },
                  ),
                ],
              )),
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                child: const ListTile(
                  title: Text("Câu hỏi đã thêm"),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(Routes.userQuestionPage,
                      arguments: {"context": context});
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
