import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_app/blocs/play/play_bloc.dart';
import 'package:puzzle_app/pages/PlayPage/option_button.dart';

class PlayPage extends StatelessWidget {
  const PlayPage({super.key});
  final text =
      '''Trên mảnh đại lục này bất luận sinh linh gì đều có tỷ lệ hóa rồng.

Truyền ngôn mỗi cái sinh mệnh đều có chính mình một đạo long môn, phóng qua đằng sau, tựa như thương khung nhật nguyệt, loá mắt huy hoàng.

Người cũng là như thế.

Long môn của người ngay tại ở hóa thân Mục Long sư.

Tìm chung quanh những tiểu ấu linh sắp hóa rồng kia, đưa chúng nó thuần dưỡng thành đương thời có một không hai Long Vương!
Mô tả trên là của truyện nào
''';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) => PlayBloc(),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                color: Colors.blue,
                height: size.height * 0.08,
                child: const Text(
                  "",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Card(
                  margin: EdgeInsets.symmetric(
                      horizontal: size.width * 0.08,
                      vertical: size.height * 0.05),
                  color: Colors.blueGrey,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        text,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.08,
                      vertical: size.height * 0.03),
                  child: LayoutBuilder(
                    builder: (context, constraints) => SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints:
                            BoxConstraints(minHeight: constraints.maxHeight),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: const [
                            OptionButton(
                              title: "Võ luyện đỉnh phong",
                              color: Colors.pink,
                              optionName: "A",
                            ),
                            OptionButton(
                              title: "Bách luyện thành thần",
                              color: Colors.purple,
                              optionName: "B",
                            ),
                            OptionButton(
                              title: "Mục long sư",
                              color: Colors.cyan,
                              optionName: "C",
                            ),
                            OptionButton(
                              title: "Nhất niệm vĩnh hằng",
                              color: Colors.orange,
                              optionName: "D",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
