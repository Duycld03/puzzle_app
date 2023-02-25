class Question {
  static int id = 0;
  String question;
  String answer;
  String optionA;
  String optionB;
  String optionC;
  String optionD;
  int categoryID;
  Question({
    required this.question,
    required this.answer,
    required this.optionA,
    required this.optionB,
    required this.optionC,
    required this.optionD,
    required this.categoryID,
  }) {
    id += 1;
  }
  factory Question.fromMap(Map<String, dynamic> map) => Question(
        question: map["question_name"],
        answer: map["answer"],
        optionA: map["option_a"],
        optionB: map["option_b"],
        optionC: map["option_c"],
        optionD: map["option_d"],
        categoryID: map["category_id"],
      );
  Map<String, dynamic> toMap() => {
        "id": id,
        "question_name": question,
        "option_a": optionA,
        "option_b": optionB,
        "option_c": optionC,
        "option_d": optionD,
        "answer": answer,
        "category_id": categoryID,
      };
}
