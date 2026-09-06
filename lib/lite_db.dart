import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class LiteDB {

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await inital();
    return _database!;
  }
  Future<Database> inital() async {
    var databasesPath = await getDatabasesPath();
    String path = p.join(databasesPath, 'lite_sql.db');

    Database database = await openDatabase(
      path,
      version: 2,
      onCreate: (Database db, int version) async {
        // When creating the db, create the table
        await db.execute('''
          CREATE TABLE PERSON (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            age INTEGER
          )
        ''');

        await db.execute('''
          CREATE TABLE ACCOUNT (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            PERSON_ID INTEGER NOT NULL,
            ACCOUNT INTEGER NOT NULL,
            VALUE REAL
          )
        ''');
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        // When upgrading the db, create the table
        if (oldVersion < 2) {
          await db.execute('''
            ALTER TABLE PERSON ADD COLUMN salary REAL  NULL DEFAULT 0.0
          ''');
        }
      },
    );

    return database;
  }

  inQuery(String query) async {
    Database? db = await database;
    //get all persons
    List<Map> list = await db.rawQuery(query);
    return list;
  }

  insert(String query) async {
    Database? db = await database;
  int count=  await db.rawInsert(query);
  return count;
  }

  update(String query) async {
    Database? db = await database;
  int count=  await db.rawUpdate(query);
  return count;
  }

  delete(String query) async {
    Database? db = await database;
    int count=  await db.rawDelete(query);
    return count;
  }
}
