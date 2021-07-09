import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _databaseName = "list_pessoas.db";
  static final _databaseVersion = 1;

  static final tableUser = 'user';

  static final userId = 'id';
  static final userName = 'name';
  static final userDocument = 'document';
  static final userIdPhone = 'id';

  static final tablePhone = 'phone';
  static final phoneId = 'phone_id';
  static final number = 'number';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  DatabaseHelper();

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  List<Object?>? get arguments => null;

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    await deleteDatabase(documentsDirectory.path);

    print(documentsDirectory.path);
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path, version: _databaseVersion, onCreate: _onCreate, onConfigure: _onConfigure);
  }

  static Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  // Código SQL para criar o banco de dados e a tabela
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $tableUser (
            $userId INTEGER PRIMARY KEY AUTOINCREMENT,
            $userName TEXT NOT NULL,
            $userDocument TEXT NOT NULL
          )
          ''');
    await db.execute('''
          CREATE TABLE $tablePhone (
            $phoneId INTEGER PRIMARY KEY AUTOINCREMENT,
            $number TEXT NOT NULL,
            $userIdPhone INTEGER,
            FOREIGN KEY ($userIdPhone) REFERENCES $tableUser($userId)
          )
          ''');
  }

  Future<int?> insertUser(Map<String, dynamic> user) async {
    Database? db = await instance.database;

    return await db?.insert(tableUser, user);
  }

  Future<int?> insertPhone(Map<String, dynamic> phone, int index) async {
    phone[DatabaseHelper.userIdPhone] = index;
    Database? db = await instance.database;
    print("Registered phone $phone");
    return await db?.insert(tablePhone, phone);
  }

  Future<List<Map<String, dynamic>>> queryAllUsers() async {
    Database? db = await instance.database;
    return await db!.query(tableUser);
  }

  Future<Map<String, dynamic>> queryUserById(num index) async {
    Database? db = await instance.database;
    List<Map<String, dynamic>> users = await db!.query(tableUser, where: '$userId = ?', whereArgs: [index], limit: 1);
    return users.first;
  }

  Future<List<Map<String, dynamic>>> queryAllUserPhones(int userId) async {
    Database? db = await instance.database;
    return await db!.query(tablePhone, where: '$userIdPhone = ?', whereArgs: [userId]);
  }

  Future<int?> updateUser(Map<String, dynamic> row, num id) async {
    Database? db = await instance.database;
    return await db!.update(tableUser, row, where: '$userId = ?', whereArgs: [id]);
  }

  Future<int?> updatePhone(Map<String, dynamic> row, num id) async {
    Database? db = await instance.database;

    return await db!.rawUpdate("UPDATE $tablePhone SET number = ? WHERE phone_id = ? ", [row[number], row[userIdPhone]]);
  }

  Future<int?> deleteUser(int id) async {
    Database? db = await instance.database;
    print('Delete id $id');
    return await db!.rawDelete("DELETE FROM $tableUser WHERE $userId = ?", [id]);
  }

  Future<int?> deletePhone(int id) async {
    Database? db = await instance.database;
    print('Delete id $id');
    return await db!.rawDelete("DELETE FROM $tablePhone WHERE $userIdPhone = ?", [id]);
  }
}
