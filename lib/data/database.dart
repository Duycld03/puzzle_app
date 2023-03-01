import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
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
    String path = join(documentsDirectory.path, "puzzleDb.db");
    bool dbExists = await File(path).exists();
    print(dbExists);
    if (!dbExists) {
      ByteData data = await rootBundle.load("assets/data/questions.db");
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes, flush: true);
    }
    return await openDatabase(path, version: 1);

    // return await openDatabase(
    //   path,
    //   version: 1,
    //   onOpen: (db) {},
    //   onCreate: (db, version) async {
    //     await db.execute(
    //       'CREATE TABLE categories(id INTEGER PRIMARY KEY AUTOINCREMENT, category_name TEXT)',
    //     );

    //     // tạo bảng user_questions với khóa ngoại category_id tham chiếu đến bảng categories
    //     await db.execute('''
    //       CREATE TABLE user_questions (
    //       id INTEGER PRIMARY KEY AUTOINCREMENT,
    //       question_name TEXT,
    //       option_a TEXT,
    //       option_b TEXT,
    //       option_c TEXT,
    //       option_d TEXT,
    //       answer TEXT,
    //       category_id INTEGER,
    //       FOREIGN KEY(category_id) REFERENCES categories(id)
    //       )
    //     ''');

    //     // tạo bảng questions với khóa ngoại category_id tham chiếu đến bảng categories
    //     await db.execute('''
    //       CREATE TABLE questions (
    //       id INTEGER PRIMARY KEY AUTOINCREMENT,
    //       question_name TEXT,
    //       option_a TEXT,
    //       option_b TEXT,
    //       option_c TEXT,
    //       option_d TEXT,
    //       answer TEXT,
    //       category_id INTEGER,
    //       FOREIGN KEY(category_id) REFERENCES categories(id)
    //       )
    //     ''');
    //   },
    // );
  }
}
