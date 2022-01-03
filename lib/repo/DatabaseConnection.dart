import 'dart:async';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseConnection {
  setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'db_colorblind');
    var database =
        await openDatabase(path, version: 1, onCreate: _onCreatingDatabase);
    return database;
  }

  FutureOr<void> _onCreatingDatabase(Database db, int version) async {
    await db.execute(""" 
    CREATE TABLE IF NOT EXISTS "Users" (
        "user_id"	INTEGER,
        "full_name"	TEXT NOT NULL,
        "age"	INTEGER NOT NULL,
        "tested_date"	TEXT NOT NULL,
        PRIMARY KEY("user_id" AUTOINCREMENT)
    )""");
    await db.execute("""
    CREATE TABLE IF NOT EXISTS "Result" (
    "user_id"	INTEGER NOT NULL,
    "corr_ans"	INTEGER NOT NULL,
    "total_cb"	INTEGER NOT NULL,
    "prot_cb"	INTEGER NOT NULL,
    "deut_cb"	INTEGER NOT NULL,
    "corr_ans_per"	REAL NOT NULL,
    "total_cb_per"	REAL NOT NULL,
    "prot_cb_per"	REAL NOT NULL,
    "deut_cb_per"	REAL NOT NULL,
    FOREIGN KEY("user_id") REFERENCES "Users"("user_id")
    )""");
    await db.execute("""
    CREATE TABLE IF NOT EXISTS "Answers" (
    "user_id"	INTEGER NOT NULL,
    "a1"	TEXT NOT NULL,
    "a2"	TEXT NOT NULL,
    "a3"	TEXT NOT NULL,
    "a4"	TEXT NOT NULL,
    "a5"	TEXT NOT NULL,
    "a6"	TEXT NOT NULL,
    "a7"	TEXT NOT NULL,
    "a8"	TEXT NOT NULL,
    "a9"	TEXT NOT NULL,
    "a10"	TEXT NOT NULL,
    "a11"	TEXT NOT NULL,
    "a12"	TEXT NOT NULL,
    "a13"	TEXT NOT NULL,
    "a14"	TEXT NOT NULL,
    "a15"	TEXT NOT NULL,
    "a16"	TEXT NOT NULL,
    "a17"	TEXT NOT NULL,
    "a18"	TEXT NOT NULL,
    "a19"	TEXT NOT NULL,
    "a20"	TEXT NOT NULL,
    "a21"	TEXT NOT NULL,
    "a22"	TEXT NOT NULL,
    "a23"	TEXT NOT NULL,
    "a24"	TEXT NOT NULL,
    "a25"	TEXT NOT NULL,
    "a26"	TEXT NOT NULL,
    "a27"	TEXT NOT NULL,
    "a28"	TEXT NOT NULL,
    "a29"	TEXT NOT NULL,
    "a30"	TEXT NOT NULL,
    "a31"	TEXT NOT NULL,
    "a32"	TEXT NOT NULL,
    "a33"	TEXT NOT NULL,
    "a34"	TEXT NOT NULL,
    "a35"	TEXT NOT NULL,
    "a36"	TEXT NOT NULL,
    "a37"	TEXT NOT NULL,
    "a38"	TEXT NOT NULL,
    FOREIGN KEY("user_id") REFERENCES "Users"("user_id")
    )""");
  }
}
