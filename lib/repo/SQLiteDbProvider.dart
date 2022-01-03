import 'package:color_blind_test/model/answer.dart';
import 'package:color_blind_test/model/result.dart';
import 'package:color_blind_test/model/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:color_blind_test/repo/DatabaseConnection.dart';

class SQLiteDbProvider {
  DatabaseConnection _databaseConnection;

  SQLiteDbProvider() {
    _databaseConnection = DatabaseConnection();
  }

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _databaseConnection.setDatabase();
    return _database;
  }

  insertData(table, Map<String, dynamic> data) async {
    var conn = await database;
    return await conn.insert(table, data);
  }

  getAllData() async {
    var conn = await database;
    return await conn.rawQuery(
        'select * from users inner join result on users.user_id = result.user_id inner join answers on users.user_id = answers.user_id');
  }

  Future<List<Map<String, dynamic>>> getTodoMapList() async {
    Database db = await this.database;
    var result = await db.rawQuery(
        'select * from users inner join result on users.user_id = result.user_id inner join answers on users.user_id = answers.user_id');
    return result;
  }

  Future<List> getAllList() async {
    var todoMapList = await getTodoMapList();
    int count =
        todoMapList.length;

    List<User> userList = List<User>();
    List<Result> resultList = List<Result>();
    List<Answer> answerList = List<Answer>();
    for (int i = 0; i < count; i++) {
      userList.add(User.fromMapObject(todoMapList[i]));
      resultList.add(Result.fromMapObject(todoMapList[i]));
      answerList.add(Answer.fromMapObject(todoMapList[i]));
    }

    return [userList, resultList, answerList];
  }
}