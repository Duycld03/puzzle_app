part of 'name_form_bloc.dart';

@immutable
class NameFormState {
  final String name;
  final bool hasName;

  const NameFormState({
    required this.name,
    required this.hasName,
  });

  get isValid => name.isNotEmpty;

  NameFormState copyWith({
    String? name,
    bool? hasName,
  }) =>
      NameFormState(
        name: name ?? this.name,
        hasName: hasName ?? this.hasName,
      );
}

class NameFormInitial extends NameFormState {
  const NameFormInitial()
      : super(
          name: "",
          hasName: false,
        );
}
