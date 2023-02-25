import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:puzzle_app/models/question.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDB();
    return _database!;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "puzzleDB.db");
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE user_questions (
        id INTEGER PRIMARY KEY,
        question_name TEXT,
        option_a TEXT,
        option_b TEXT,
        option_c TEXT,
        option_d TEXT,
        answer TEXT,
        category_id INTEGER
        )''');
      },
    );
  }

  Future<int> newQuestion(Question newQuestion) async {
    final db = await database;
    var res = await db.insert("user_questions", newQuestion.toMap());
    return res;
  }

  getQuestion(int id) async {
    final db = await database;
    var res =
        await db.query("user_questions", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Question.fromMap(res.first) : null;
  }

  Future<List<Question>> getAllQuestion() async {
    final db = await database;
    var res = await db.query("user_questions");
    List<Question> list =
        res.isNotEmpty ? res.map((q) => Question.fromMap(q)).toList() : [];
    return list;
  }

  deleteQuestion(int id) async {
    final db = await database;
    db.delete("user_questions", where: "id = ?", whereArgs: [id]);
  }

  deleteAllQuestion(int id) async {
    final db = await database;
    db.delete("user_questions");
  }
}
