import '../repository/DatabaseHelper.dart';

class CategoryModel {
  int? categoryid;
  String? name;

  CategoryModel({this.categoryid,
        this.name,
      });

  toJson() {
    var map = <String, dynamic>{
      'categoryid': categoryid,
      'name': name,
    };
    return map;
  }

  CategoryModel.fromJson(Map<String, dynamic> data) {
    categoryid = data['categoryid'];
    name = data['name'];
  }
}


class CategoryDao {
  static const tableName = 'Category';
  static const categoryid = 'categoryid';
  static const name = 'name';
  late DatabaseHelper dbHelper;

  CategoryDao() {
    dbHelper = DatabaseHelper();
  }

  static String createSQL =
      'CREATE TABLE $tableName ( $categoryid INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, $name TEXT)';

  Future<int> insert(CategoryModel category) async {
    final dbClient = await dbHelper.db;
    return await dbClient.insert(tableName, category.toJson());
  }
  Future<List<CategoryModel>> getAllCategories() async {
    final dbClient = await dbHelper.db;
    final List<Map<String, dynamic>> maps = await dbClient.query(tableName);

    return List.generate(maps.length, (i) {
      return CategoryModel.fromJson(maps[i]);
    });
  }


  Future<int> deleteAll() async {
    final dbClient = await dbHelper.db;
    return await dbClient.delete(tableName);
  }
  Future<void> insertInitialCategories() async {
    List<CategoryModel> categories = [
      CategoryModel(name: 'Groceries'),
      CategoryModel(name: 'Utilities'),
      CategoryModel(name: 'Transportation'),
      CategoryModel(name: 'Entertainment'),
      CategoryModel(name: 'Healthcare'),
      CategoryModel(name: 'Education'),
      CategoryModel(name: 'Dining Out'),
      CategoryModel(name: 'Rent/Mortgage'),
      CategoryModel(name: 'Savings'),
      CategoryModel(name: 'Insurance'),
      CategoryModel(name: 'Other'),
    ];

    for (var category in categories) {
      await insert(category);
    }
  }


}
