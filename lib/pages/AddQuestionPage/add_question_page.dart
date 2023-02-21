import 'package:flutter/material.dart';
import 'package:puzzle_app/fake_data.dart';

List<String> options = ["A", "B", "C", "D"];

class AddQuestionPage extends StatelessWidget {
  AddQuestionPage({super.key});
  final _question = {'value': '', 'correct': options[0], 'options': options};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Câu hỏi")),
      body: Form(
        // key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: const EdgeInsets.all(32),
          children: [
            TextFormField(
              // controller: _questionCtrl,
              decoration: const InputDecoration(
                  labelText: 'Câu hỏi *', border: OutlineInputBorder()),
              validator: (v) => v!.isEmpty ? "Vui lòng điền câu hỏi" : null,
            ),
            const SizedBox(height: 32),
            const Text("Lựa chọn đúng"),
            Row(
                children: options
                    .map((option) => [
                          Radio<String>(
                              value: option,
                              groupValue: _question['correct'] as String,
                              onChanged: (v) => {}
                              // setState(() => _question['correct'] = v!),
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
                        // controller: _optionCtrls[entry.key],
                        decoration: InputDecoration(
                          labelText: "Lựa chọn ${entry.value}*",
                          border: const OutlineInputBorder(),
                        ),
                        validator: (v) => v!.isEmpty
                            ? "Vui lòng điền lựa chọn ${entry.value}"
                            : null,
                      ),
                      const SizedBox(height: 32),
                    ])
                .expand((w) => w),
            DropdownButton(
              isExpanded: true,
              underline: Container(
                height: 2,
                color: Colors.blue,
              ),
              items: fake_categories
                  .asMap()
                  .entries
                  .map(
                    (entry) => DropdownMenuItem(
                      value: entry.key,
                      child: Text(entry.value),
                    ),
                  )
                  .toList(),
              onChanged: (e) {
                print(e);
              },
            ),
            const SizedBox(height: 32),
            ElevatedButton(
                onPressed: () {},
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Thêm",
                    style: TextStyle(fontSize: 16),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
