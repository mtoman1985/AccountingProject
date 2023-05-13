import 'package:belal_pro/db/dbhelper.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class DbBuilding {
  // CREATE TABLE "P_buildings" (
  // "building_id"	INTEGER NOT NULL UNIQUE,
  // "building_first_payment"	INTEGER,
  // "project_id"	INTEGER,
  // "building_check_no"	NUMERIC,
  // "building_penfit"	INTEGER,
  // "building_total_value"	INTEGER
  // );
  DbHelper dbHelper = DbHelper();
  Future<List<Map<String, Object?>>> allBuildings() async {
    Database? db = await dbHelper.openDb();
    String sql = 'SELECT * from P_buildings ORDER by building_id ASC';
    return db!.rawQuery(sql);
  }
  Future<List<Map<String, Object?>>> searchBuildingById( int id) async {
    Database? db = await dbHelper.openDb();
    String sql = 'SELECT * from P_buildings WHERE building_id=$id ORDER by building_id ASC';
    return db!.rawQuery(sql);
  }

  deleteProject(int id) async {
    Database? db = await dbHelper.openDb();
    String sql = 'DELETE FROM P_buildings  WHERE building_id=$id';
    db!.rawQuery(sql);
  }

  Future<Future<List<Map<String, Object?>>>?> searchingBuildings(
      String name) async {
    Database? db = await dbHelper.openDb();
    String sql = "";
    if (name.isNotEmpty) {
      sql =
      'SELECT * from  project	 WHERE P_buildings like "$name%"  or person_name like "%$name"  or person_name like "%$name%" ORDER by person_name ASC';
    } else {
      sql = 'SELECT * from  project ORDER by P_buildings ASC';
    }
    return db?.rawQuery(sql);
  }


  // CREATE TABLE "P_buildings" (
  /// "building_id"	INTEGER NOT NULL UNIQUE,
  // "building_first_payment"	INTEGER,
  // "project_id"	INTEGER,
  // "building_check_no"	NUMERIC,
  // "building_penfit"	INTEGER,
  // "building_total_value"	INTEGER
  // );

  Future<void> addBuilding(
  int building_first_payment,
  int project_id,
  int projectCheckNo,
  int projectPenfit,
  int building_total_value
  ) async {
  Database? db = await dbHelper.openDb();

  return db!.execute(
  'INSERT INTO P_buildings (building_first_payment, project_id, projectCheckNo , building_total_value ) VALUES ("$building_first_payment","$project_id","$projectCheckNo","$building_total_value");');
  }
}
