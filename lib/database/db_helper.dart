import 'package:geideaflutter/rest/response/data.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SQLiteDBHelper{

  Future<Database> database;

  void openDb()async{
    database = openDatabase(

        join(await getDatabasesPath(), 'geidea_database.db'),
        onCreate: (db, version) {
          return db.execute(
            "CREATE TABLE data(id INTEGER PRIMARY KEY, first_name TEXT,"
                "last_name TEXT,"
                "email TEXT,"
                " avatar TEXT)",
          );
        },version: 1
    );
  }

  Future<void> insertData(List<Data> data) async {
    // Get a reference to the database.
    final Database db = await database;

    for(int i =0;i<data.length;i++){
      await db.insert(
        'data',
        data[i].toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

}

  Future<List<Data>> dataList() async {

    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('data');

    return List.generate(maps.length, (i) {
      return Data(
        id: maps[i]['id'],
        firstName: maps[i]['first_name'],
        lastName: maps[i]['last_name'],
        email: maps[i]['email'],
        avatar: maps[i]['avatar'],
      );
    });

  }

  Future<Data> findById(int userId)async {
    final Database db = await database;

    List<Map> results = await db.query("data",
        columns: ["id", "first_name", "last_name", "email","avatar"],
        where: 'id = ?',
        whereArgs: [userId]);

    print(results.length);
    if (results.length > 0) {
      return new Data.fromJson(results.first);
    }

    return null;
  }
}