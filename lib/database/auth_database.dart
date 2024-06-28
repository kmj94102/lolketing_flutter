import 'package:lolketing_flutter/database/database_helper.dart';
import 'package:lolketing_flutter/model/login_model.dart';
import 'package:sqflite/sqflite.dart';

class AuthDatabase {
  static final AuthDatabase _instance = AuthDatabase._internal();

  factory AuthDatabase() {
    return _instance;
  }

  AuthDatabase._internal();

  final DatabaseHelper _helper = DatabaseHelper();

  Future<void> insertLoginInfo(LoginResult info) async {
    final db = await _helper.database;
    var result = await db.insert(_helper.auth, info.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
    print(result);
  }

  Future<LoginResult?> fetchLoginInfo() async {
    final db = await _helper.database;
    List<Map<String, dynamic>> result = await db.query(_helper.auth);
    return result.isEmpty
        ? null
        : LoginResult.fromJson(result.first);
  }

}