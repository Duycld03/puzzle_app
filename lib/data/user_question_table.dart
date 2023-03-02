import 'package:puzzle_app/data/database.dart';
import 'package:puzzle_app/models/question.dart';

class UserQuestionTable {
  final String tableName = "user_question";
  UserQuestionTable._();
  static final UserQuestionTable instance = UserQuestionTable._();

  Future<int> newUserQuestion(Question newQuestion) async {
    final db = await DBProvider.db.database;
    var res = await db.insert(tableName, newQuestion.toMap());
    return res;
  }

  getUserQuestion(int id) async {
    final db = await DBProvider.db.database;
    var res = await db.query(tableName, where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Question.fromMap(res.first) : null;
  }

  Future<List<Question>> getAllUserQuestion() async {
    final db = await DBProvider.db.database;
    var res =
        await db.query(tableName, where: "maker = ?", whereArgs: ["User"]);
    List<Question> list =
        res.isNotEmpty ? res.map((q) => Question.fromMap(q)).toList() : [];
    return list;
  }

  deleteUserQuestion(int id) async {
    final db = await DBProvider.db.database;
    db.delete(tableName, where: "id = ?", whereArgs: [id]);
  }

  deleteAllUserQuestion(int id) async {
    final db = await DBProvider.db.database;
    db.delete(tableName);
  }
}
