class Topic {
  int? id;
  String name;
  Topic({
    this.id,
    required this.name,
  });

  factory Topic.fromMap(Map<String, dynamic> map) => Topic(
        id: map["topic_id"],
        name: map["question_topic"],
      );
  Map<String, dynamic> toMap() => {
        "topic_id": id,
        "question_topic": name,
      };
}
