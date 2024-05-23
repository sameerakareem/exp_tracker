

import '../repository/DatabaseHelper.dart';

class ProfileModel {
  int? userid;
  String? userName;
  String? phone;
  String? password;
  String? email;


  ProfileModel(
      {this.userid,
      this.userName,
      this.phone,
      this.password,
      this.email,
   });

  toJson() {
    var map = <String, dynamic>{
      'userid': userid,
      'userName': userName,
      'phone': phone,
      'password': password,
      'email': email,


    };
    return map;
  }

  ProfileModel.fromJson(Map<String, dynamic> data) {
    userid = data['userid'];
    userName = data['userName'];
    phone = data['phone'];
    password = data['password'];
    email = data['email'];

  }
}
class UserDetailsDao {
  static const tableName = 'UserDetails';
  static const userid = 'userid';
  static const userName = 'userName';
  static const phone = 'phone';
  static const password = 'password';
  static const email = 'email';

  late DatabaseHelper dbHelper;

  UserDetailsDao() {
    dbHelper = DatabaseHelper();
  }

  static String createSQL =
      'CREATE TABLE $tableName ( $userid INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, $userName TEXT, $phone TEXT, $password TEXT,'
      ' $email TEXT)';

  Future<int> insert(ProfileModel user) async {
    final dbClient = await dbHelper.db;
    return await dbClient.insert(tableName, user.toJson());
  }

  Future<ProfileModel?> getUserByCredentials(String _userName, String _password) async {
    final dbClient = await dbHelper.db;
    List<Map<String, dynamic>> result = await dbClient.query(
      tableName,
      where: '$userName = ? AND $password = ?',
      whereArgs: [_userName, _password],
    );

    if (result.isNotEmpty) {
      return ProfileModel.fromJson(result.first);
    } else {
      return null;
    }
  }
}
