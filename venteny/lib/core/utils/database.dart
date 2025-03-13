import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:venteny/core/errors/exceptions.dart';

import '../../src/home/data/models/home_model.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._init();

  static Database? _database;

  DatabaseService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('task.db');

    return _database!;
  }

  Future<Database> _initDB(String filepath) async {
    final dbPath = await getDatabasesPath();

    final path = join(dbPath, filepath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

 Future _createDB(Database db, int version) async {
  final textType = 'TEXT NOT NULL';
  final intType = 'INTEGER NOT NULL';

  await db.execute('''
    CREATE TABLE task (
      ${ResultField.id} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${ResultField.title} TEXT NOT NULL CHECK(LENGTH(${ResultField.title}) <= 50),
      ${ResultField.description} $textType,
      ${ResultField.date} $textType,
      ${ResultField.status} $intType
    )
  ''');
}


  Future<TasksModel> create(TasksModel note) async {
     try {
       final db = await instance.database;
    final id = await db.insert("task", note.toJson());
    return note.copy(id: id);
     } on DatabaseException catch (e) {
       throw ApiException(e.toString());
     }
  }

 Future<List<TasksModel>> searchTask({String? title, int? status}) async {
  final db = await instance.database;
  

  print('searchhh $title');
  print('searchhh $status');
  String whereString = "";
  List<dynamic> whereArgs = [];

  if (title != null && title.isNotEmpty) {
    whereString = "${ResultField.title} LIKE ?";
    whereArgs.add("%$title%");
  }

  if (status != null) {
    if (whereString.isNotEmpty) whereString += " AND ";
    whereString += "${ResultField.status} = ?";
    whereArgs.add(status);
  }

  final maps = await db.query(
    "task",
    columns: ResultField.values,
    where: whereString.isNotEmpty ? whereString : null,
    whereArgs: whereArgs.isNotEmpty ? whereArgs : null,
  );

  print('Hasil pencarian: $maps');

  if (maps.isNotEmpty) {
    return maps.map<TasksModel>((e) => TasksModel.fromJson(e)).toList();
  } else {
    return [];
  }
}


  Future<List<TasksModel>> readAllNotes() async {
    final db = await instance.database;

    final result = await db.query("task");

    return result.map((e) => TasksModel.fromJson(e)).toList();
  }

  Future<bool> update(TasksModel resultOffline) async {
    final db = await instance.database;
    
    await db.update("task", resultOffline.toJson(),
        where: '${ResultField.id}= ?', whereArgs: [resultOffline.id]);

    return Future.value(true);
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    int result = await db
        .delete("task", where: '${ResultField.id} = ?', whereArgs: [id]);
    return result;
  }

}
