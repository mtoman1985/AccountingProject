import 'package:belal_pro/db/dbhelper.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class DbProject {
  // "project" (
// 	"project_id"	INTEGER NOT NULL,
// 	"project_name"	TEXT,
// 	"project_person_no"	INTEGER,
// 	"project_start_date"	TEXT,
// 	"project_value"	INTEGER,
// 	"project_currency"	TEXT,
// 	"project_first_payment"	INTEGER,
// 	"project_check_no"	INTEGER,
// 	"project_penfit"	INTEGER,
// 	"project_total_value"	INTEGER,
// 	PRIMARY KEY("project_id" AUTOINCREMENT)
  DbHelper dbHelper = DbHelper();

  Future<List<Map<String, Object?>>> allProjects() async {
    Database? db = await dbHelper.openDb();
    String sql = 'SELECT * from project ORDER by project_name ASC';
    return db!.rawQuery(sql);
  }
  Future<List<Map<String, Object?>>> searchProjectById( int id) async {
    Database? db = await dbHelper.openDb();
    String sql = 'SELECT * from project WHERE project_id=$id ORDER by project_name ASC';
    return db!.rawQuery(sql);
  }

  deleteProject(int id) async {
    Database? db = await dbHelper.openDb();
    String sql = 'DELETE FROM project  WHERE project_id=$id';
    db!.rawQuery(sql);
  }

  Future<Future<List<Map<String, Object?>>>?> searchingProjects(
      String name) async {
    Database? db = await dbHelper.openDb();
    String sql = "";
    if (name.isNotEmpty) {
      sql =
          'SELECT * from  project	 WHERE project_name like "$name%"  or person_name like "%$name"  or person_name like "%$name%" ORDER by person_name ASC';
    } else {
      sql = 'SELECT * from  project ORDER by project_name ASC';
    }
    return db?.rawQuery(sql);
  }

  Future<void> addProject(
      String projectName,
      String projectPersonNo,
      String projectStartDate,
      int projectValue,
      String projectCurrency,
      int projectFirstPayment,
      int projectCheckNo,
      int projectPenfit) async {
    Database? db = await dbHelper.openDb();
    //"project_name"	TEXT,
// 	"project_person_no"	INTEGER,
// 	"project_start_date"	TEXT,
// 	"project_value"	INTEGER,
// 	"project_currency"	TEXT,
// 	"project_first_payment"	INTEGER,
// 	"project_check_no"	INTEGER,
// 	"project_penfit"	INTEGER,
// 	"project_total_value"	INTEGER,
    return db!.execute(
        'INSERT INTO project (project_name, project_person_no, project_start_date , project_value, project_currency, project_first_payment, project_check_no, project_penfit ) VALUES ("$projectName","$projectPersonNo","$projectStartDate","$projectValue","$projectCurrency","$projectFirstPayment","$projectCheckNo","$projectPenfit" );');
  }
}
