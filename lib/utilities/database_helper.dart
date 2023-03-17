import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

import '../models/signup_model.dart';

class DatabaseHelper {
  DatabaseHelper() {
    database();
  }
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'users.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE schedule(id INTEGER PRIMARY KEY AUTOINCREMENT, username string, email string, password string)');
      },
      version: 1,
    );
  }

  Future<void> addUsers(Logup signUp) async {
    final db = await database();
    await db.insert(
      'users',
      signUp.toMap(),
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  Future<List<Logup>> getUsers() async {
    final db = await database();

    final List<Map<String, dynamic>> maps = await db.query('users');

    return List.generate(maps.length, (i) {
      return Logup(
        id: maps[i]['id'],
        username: maps[i]['username'],
        email: maps[i]['email'],
        password: maps[i]['password'],
      );
    });
  }
}
