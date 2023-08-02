import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper.internal();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'asgard.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE asgard_info (id INTEGER PRIMARY KEY, name TEXT, surname TEXT, age INTEGER, email TEXT)');
  }

  Future<int> deleteAsgardInfo(int id) async {
    Database db = await database;
    return await db.delete('asgard_info', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> saveAsgardInfo(Map<String, dynamic> info) async {
    Database db = await database;
    return await db.insert('asgard_info', info);
  }

  Future<List<Map<String, dynamic>>> getAllAsgardInfo() async {
    Database db = await database;
    return await db.query('asgard_info');
  }
}
