class Question {
  int? id;
  String maker;
  String question;
  String answer;
  String? optionA;
  String? optionB;
  String? optionC;
  String? optionD;
  String? explain;
  String category;
  int topicID;
  Question({
    this.id,
    required this.maker,
    required this.question,
    required this.answer,
    this.optionA,
    this.optionB,
    this.optionC,
    this.optionD,
    this.explain,
    required this.category,
    required this.topicID,
  });
  factory Question.fromMap(Map<String, dynamic> map) => Question(
        id: map["id"],
        maker: map["maker"],
        question: map["name"],
        answer: map["answer"],
        optionA: map["option_a"],
        optionB: map["option_b"],
        optionC: map["option_c"],
        optionD: map["option_d"],
        explain: map["explain"],
        category: map["category"],
        topicID: map["topic_id"],
      );
  Map<String, dynamic> toMap() => {
        "id": id,
        "maker": maker,
        "name": question,
        "option_a": optionA ?? "",
        "option_b": optionB ?? "",
        "option_c": optionC ?? "",
        "option_d": optionD ?? "",
        "answer": answer,
        "explain": explain ?? "",
        "category": category,
        "topic_id": topicID,
      };
}
