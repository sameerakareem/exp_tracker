import 'package:intl/intl.dart';

import '../repository/DatabaseHelper.dart';

class ExpenseModel {
  int? id;
  String? name;
  String? type;
  String? date;
  int? amount;
  String? categoryName;
  String? Note;

  ExpenseModel({
    this.id,
    this.name,
    this.type,
    this.date,
    this.amount,
    this.categoryName,
    this.Note,
  });

  ExpenseModel.fromJson(Map<String, dynamic> data) {
    id = data['id'] is int ? data['id'] : int.tryParse(data['id'].toString());
    name = data['name'];
    type = data['type'];
    date = data['date'];
    amount = data['amount'] is int ? data['amount'] : int.tryParse(data['amount'].toString());
    categoryName = data['categoryName'];
    Note = data['Note'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'date': date,
      'amount': amount,
      'categoryName': categoryName,
      'Note': Note,
    };
  }

}
class ExpenseDao {
  static const tableName = 'ExpenseDetails';
  static const id = 'id';
  static const name = 'name';
  static const type = 'type';
  static const date = 'date';
  static const amount = 'amount';

  static const categoryName = 'categoryName';
  static const Note = 'Note';


  late DatabaseHelper dbHelper;

  ExpenseDao() {
    dbHelper = DatabaseHelper();
  }

  static String createSQL =
      'CREATE TABLE $tableName ( $id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, $name TEXT, $type TEXT, $date TEXT, $amount TEXT,'
      ' $categoryName TEXT,  $Note TEXT)';

  Future<int> insert(ExpenseModel expense) async {
    final dbClient = await dbHelper.db;
    return await dbClient.insert(tableName, expense.toJson());
  }
  Future<double> getTotalAmountByTypeAndDate(String expenseType, String expenseDate) async {
    final dbClient = await dbHelper.db;
    final List<Map<String, dynamic>> result = await dbClient.rawQuery(
      'SELECT SUM($amount) as total FROM $tableName WHERE $type = ? AND $date = ?',
      [expenseType, expenseDate],
    );

    if (result.isNotEmpty && result.first['total'] != null) {
      return (result.first['total'] as int).toDouble();
    } else {
      return 0.0;
    }
  }
  Future<int> deleteExpense(int _id) async {
    final dbClient = await dbHelper.db;
    return await dbClient.delete(
      tableName,
      where: '$id = ?',
      whereArgs: [_id],
    );
  }
  Future<int> updateExpense(int _id, int newAmount) async {
    final dbClient = await dbHelper.db;
    return await dbClient.update(
      tableName,
      {

        amount: newAmount,

      },
      where: '$id = ?',
      whereArgs: [_id],
    );
  }

  Future<List<ExpenseModel>> getExpensesByDate(DateTime fromDate) async {
    final dbClient = await dbHelper.db;
    String formattedDate = DateFormat('dd-MM-yyyy').format(fromDate);
    String query = '''
    SELECT $categoryName, SUM($amount) as amount
    FROM $tableName
    WHERE $date >= ? AND $type = 'Expense'
    GROUP BY $categoryName
    ORDER BY $categoryName
  ''';
    List<Map<String, dynamic>> result = await dbClient.rawQuery(query, [formattedDate]);

    return result.map((map) => ExpenseModel.fromJson(map)).toList();
  }

  Future<List<ExpenseModel>> getExpenses() async {
    final dbClient = await dbHelper.db;
    String query = '''
  SELECT * FROM $tableName WHERE $type = 'Expense'
''';
    List<Map<String, dynamic>> result = await dbClient.rawQuery(query);

    return result.map((map) => ExpenseModel.fromJson(map)).toList();
  }

}
