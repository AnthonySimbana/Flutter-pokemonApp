import 'package:path/path.dart';
import 'package:pokedex_mobile/dtos/category_model.dart';
import 'package:sqflite/sqflite.dart';

class CategoryDatabase {
  //static final CategoryDatabase instance = CategoryDatabase._init();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('pokedex.db');
    return _database!;
  }

  Future<Database> _initDB(String file) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, file);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    //INTEGER
    //TEXT
    //BOOLEAN
    //BLOB
    await db.execute('''
      CREATE TABLE $tableCategory (
        ${CategoryField.id} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${CategoryField.name} TEXT NOT NULL,
        ${CategoryField.image} TEXT NOT NULL
      )
    ''');
  }
}
