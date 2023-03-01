class Question {
  int? id;
  String question;
  String answer;
  String optionA;
  String optionB;
  String optionC;
  String optionD;
  String? explain;
  int categoryID;
  Question({
    this.id,
    required this.question,
    required this.answer,
    required this.optionA,
    required this.optionB,
    required this.optionC,
    required this.optionD,
    this.explain,
    required this.categoryID,
  });
  factory Question.fromMap(Map<String, dynamic> map) => Question(
        question: map["name"],
        answer: map["answer"],
        optionA: map["option_a"],
        optionB: map["option_b"],
        optionC: map["option_c"],
        optionD: map["option_d"],
        explain: map["explain"],
        categoryID: map["category_id"],
      );
  Map<String, dynamic> toMap() => {
        "question_name": question,
        "option_a": optionA,
        "option_b": optionB,
        "option_c": optionC,
        "option_d": optionD,
        "answer": answer,
        "explain": explain ?? "",
        "category_id": categoryID,
      };
}
