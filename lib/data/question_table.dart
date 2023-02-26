import 'package:puzzle_app/data/database.dart';
import 'package:puzzle_app/models/question.dart';

class QuestionTable {
  final String tableName = "questions";
  QuestionTable._();
  static final QuestionTable instance = QuestionTable._();

  getQuestion(int id) async {
    final db = await DBProvider.db.database;
    var res = await db.query(tableName, where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Question.fromMap(res.first) : null;
  }

  Future<List<Question>> getAllQuestion() async {
    final db = await DBProvider.db.database;
    var res = await db.query(tableName);
    List<Question> list =
        res.isNotEmpty ? res.map((q) => Question.fromMap(q)).toList() : [];
    return list;
  }
}
