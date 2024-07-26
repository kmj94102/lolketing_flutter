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
    await db.insert(_helper.auth, info.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<LoginResult> fetchLoginInfo() async {
    final db = await _helper.database;
    List<Map<String, dynamic>> result = await db.query(_helper.auth);
    return result.isEmpty
        ? throw('유저 정보가 없습니다.')
        : LoginResult.fromJson(result.first);
  }

  Future<LoginResult?> fetchUser() async {
    final db = await _helper.database;
    List<Map<String, dynamic>> result = await db.query(_helper.auth);
    return result.isEmpty
        ? null
        : LoginResult.fromJson(result.first);
  }

  Future<int> fetchUserIndex() async {
    final db = await _helper.database;
    List<Map<String, dynamic>> result = await db.query(_helper.auth);
    return result.isEmpty
        ? throw('유저 정보가 없습니다.')
        : LoginResult.fromJson(result.first).id;
  }

  Future<String> fetchUserId() async {
    final db = await _helper.database;
    List<Map<String, dynamic>> result = await db.query(_helper.auth);
    return result.isEmpty
        ? throw('유저 정보가 없습니다.')
        : LoginResult.fromJson(result.first).email;
  }

  Future<void> logout() async {
    final db = await _helper.database;
    final id = await fetchUserIndex();

    db.delete(_helper.auth, where: 'id = ?', whereArgs: [id]);
  }

}