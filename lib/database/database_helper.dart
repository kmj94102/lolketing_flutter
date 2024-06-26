import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;
  final auth = 'auth';
  final cart = 'cart';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'lolketing_flutter.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $auth(
            idx INTEGER PRIMARY KEY AUTOINCREMENT,
            id INTEGER,
            email TEXT,
            nickname TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE $cart(
            idx INTEGER PRIMARY KEY AUTOINCREMENT,
            category TEXT,
            name TEXT,
            price INTEGER,
            amount INTEGER,
            isChecked INTEGER,
            image TEXT,
            goodsId INTEGER
          )
        ''');
      },
    );
  }
}