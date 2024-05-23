import 'dart:convert';
import 'dart:io';

import 'package:expence_tracker/models/expenses_model.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../models/category_model.dart';
import '../models/profile_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  static const dbName = 'expensetracker.db';
  static const dbVersion = 1;

  factory DatabaseHelper() => _instance;

  static Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb();
    return _db!;
  }

  DatabaseHelper.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    // Construct the path to the database file.
    String path = join(documentDirectory.path, dbName);

    // Open the database and store the reference.
    var db = await openDatabase(path, version: 1, onCreate: _onCreate, onUpgrade: onUpgrade);

    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(UserDetailsDao.createSQL);
    await db.execute(CategoryDao.createSQL);
    await db.execute(ExpenseDao.createSQL);


    print("Table is created");
  }

  static Future<List<Map<String, dynamic>>> query(String table) async =>
      _db!.query(table);

  FutureOr<void> onUpgrade(Database db, int oldVersion, int newVersion) {
    switch (newVersion) {}
  }
}
