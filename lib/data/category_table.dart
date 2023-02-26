import 'package:puzzle_app/data/database.dart';
import 'package:puzzle_app/models/category.dart';

class CategoryTable {
  final tableName = "categories";
  CategoryTable._();
  static final CategoryTable instance = CategoryTable._();

  getUserQuestion(int id) async {
    final db = await DBProvider.db.database;
    var res = await db.query(tableName, where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Category.fromMap(res.first) : null;
  }

  Future<List<Category>> getAllUserCategory() async {
    final db = await DBProvider.db.database;
    var res = await db.query(tableName);
    List<Category> list =
        res.isNotEmpty ? res.map((q) => Category.fromMap(q)).toList() : [];
    return list;
  }

  Future<List<Map<String, dynamic>>?> getCategoryByQuestion(
      int questionID) async {
    final db = await DBProvider.db.database;
    List<Map<String, dynamic>> maps = await db.query(
      'foods JOIN categories ON questions.category_id = categories.id',
      // lấy các trường từ cả hai bảng
      columns: ['categories.id', 'categories.name'],
      // điều kiện WHERE để lấy chỉ một món ăn dựa trên id
      where: 'foods.id = ?',
      whereArgs: [questionID],
    );
    return maps;
  }
}
