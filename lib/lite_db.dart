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
      version: 1,
      onCreate: (Database db, int version) async {
        // When creating the db, create the table
        await db.execute('''
              CREATE TABLE PERSON (id INTEGER AUTOINCREMENT PRIMARY KEY, name TEXT NOT NULL, age INTEGER);
              CREATE TABLE ACCOUNT (id INTEGER AUTOINCREMENT PRIMARY KEY,PERSON_ID INTEGER NOT NULL ,ACCOUNT INTEGER NOT NULL, VALUE REAL);
          ''');
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
