import 'dart:io';

import 'package:final_project/UserModel.dart';
import 'package:final_project/EventModel.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper {
  static const _databaseName = 'mainDatabase.db';
  static const _databaseVersion = 1;

  static const userst = 'userst';
  static const usersid = 'id';
  static const username = 'name';
  static const userpass = 'password';

  static const eventst = 'events';
  static const eventid = 'id';
  static const eventname = 'name';
  static const eventdes = 'description';
  static const eventtime = 'time';






  //singleton
  DataBaseHelper._constructDB();
  static final DataBaseHelper instance = DataBaseHelper._constructDB();
  static Database? _database;

  //get the database
  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await _initiateDB();
    return _database;
  }

  //initialize the database
  Future<Database?> _initiateDB() async {
    print('getting database path');
    Directory directory = await getApplicationDocumentsDirectory();
    print(directory.path);
    String path = join(directory.path, _databaseName);
    print(path);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate,
        onConfigure: _onConfigure);
  }

  //Create table(s) when creating DB
  Future<void> _onCreate(Database database, int version) async {
    //Create users table
    await database.execute('''
    CREATE TABLE $userst (
    $usersid INT PRIMARY KEY,
    $username TEXT NOT NULL,
    $userpass TEXT NOT NULL
    )
    ''');
    //Create users table
    await database.execute('''
    CREATE TABLE $eventst (
    $eventid INT FOREIGN KEY,
    $eventname TEXT NOT NULL,
    $eventdes TEXT NOT NULL,
    $eventtime TEXT NOT NULL
    FOREIGN KEY($eventid) REFERENCES $userst ($usersid)
    )
    ''');
  }

  static Future _onConfigure(Database database) async {
    await database.execute('PRAGMA foreign_keys = ON');
  }

  Future<int> getUsersCount() async {
    Database? db = await DataBaseHelper.instance.database;
    List<Map<String,dynamic>>? result = await db?.rawQuery('''SELECT *
    FROM $userst''');
    int length = result?.length ?? 0;
    return length;
  }

  Future<User?> checkPassword(String name,String pass)async{
    Database? db = await DataBaseHelper.instance.database;
    List<Map<String,dynamic>>? result = await db?.rawQuery('''SELECT *
    FROM $userst
    WHERE $username = ? AND
    $userpass = ?''',[name,pass]);
    int length = result?.length ?? 0;
    if(length != 0){
      print("${result?[0][usersid]} ${result?[0][username]} ${result?[0][userpass]} ");
      return User(id: result?[0][usersid],name: result?[0][username],password: result?[0][userpass],);
    }
    else{
      return null;
    }
  }

  Future<void> insertUser(User user)async{
    String name = user.name;
    Database? db = await DataBaseHelper.instance.database;
    List<Map<String,dynamic>>? result = await db?.query(userst,where: '$username = ?',whereArgs: [name]);
    int length = result?.length ?? 0;
    if(length != 0){
      print('fuck off');
      return;
    }
    await db?.insert(userst, user.toMap(),conflictAlgorithm: ConflictAlgorithm.fail);
  }

  Future<void> insertEvent(Alarm alarm)async{
    Database? db = await DataBaseHelper.instance.database;
    await db?.insert(userst, alarm.toMap(),conflictAlgorithm: ConflictAlgorithm.fail);
  }
}