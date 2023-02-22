part of 'navbar_bloc.dart';

@immutable
abstract class NavbarState {
  final String title = "";
  final int itemIndex = 0;
}

class ShowHome extends NavbarState {
  String title = "Trang chủ";
  int itemIndex = 1;
}

class ShowQuestion extends NavbarState {
  String title = "Thêm Câu hỏi";
  int itemIndex = 0;
}

class ShowSetting extends NavbarState {
  String title = "Cài đặt";
  int itemIndex = 2;
}

class NavbarInitial extends NavbarState {}
