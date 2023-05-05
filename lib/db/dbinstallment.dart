import 'package:belal_pro/db/dbhelper.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class DbInstallment {
// CREATE TABLE "installments" (
// 	"installment_id"	INTEGER NOT NULL,
// 	"installment_type"	TEXT DEFAULT 'المشاريع',
// 	"installment_type_id"	INTEGER,
// 	"installment_date"	TEXT,
// 	"installment_kind"	TEXT DEFAULT 'شيك',
// 	"installment_value"	INTEGER,
// 	"installment_currency"	TEXT DEFAULT 'شيكل',
// 	"installment_meritDate"	INTEGER,
// 	"installment_payed"	TEXT DEFAULT 'لا',
// 	"installment_picutre"	TEXT,
  DbHelper dbHelper = DbHelper();

  Future<List<Map<String, Object?>>> allInstallments() async {
    Database? db = await dbHelper.openDb();
    String sql = 'SELECT * from installments ORDER by installment_id ASC';
    return db!.rawQuery(sql);
  }
  Future<List<Map<String, Object?>>> adteInstallment_count() async {
    Database? db = await dbHelper.openDb();
    String sql = 'SELECT * from Selected_date_installment ';
    return db!.rawQuery(sql);
  }

  deleteInstallment(int id) async {
    Database? db = await dbHelper.openDb();
    String sql = 'DELETE FROM installments  WHERE installment_id=$id';
    db!.rawQuery(sql);
  }
// Delete
  Future<Future<List<Map<String, Object?>>>?> searchingInstallments(
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

  Future<void> addInstallment(
      String installmentType,
      String installmentTypeId,
      String installmentDate,
      String installmentKind,
      int installmentValue,
      String installmentCurrency,
      String installmentMeritDate,
      String installmentPayed,
      String installmentPicutre ) async {
    Database? db = await dbHelper.openDb();
// CREATE TABLE "installments" (
// 	"installment_id"	INTEGER NOT NULL,
// 	"installment_type"	TEXT DEFAULT 'المشاريع',
// 	"installment_type_id"	INTEGER,
// 	"installment_date"	TEXT,
// 	"installment_kind"	TEXT DEFAULT 'شيك',
// 	"installment_value"	INTEGER,
// 	"installment_currency"	TEXT DEFAULT 'شيكل',
// 	"installment_meritDate"	INTEGER,
// 	"installment_payed"	TEXT DEFAULT 'لا',
// 	"installment_picutre"	TEXT,
    return db!.execute(
        'INSERT INTO installments ( installment_type, installment_type_id , installment_date, installment_kind, installment_value, installment_currency, installment_meritDate, installment_payed, installment_picutre ) VALUES ("$installmentType","$installmentTypeId","$installmentDate","$installmentKind","$installmentValue","$installmentCurrency","$installmentMeritDate","$installmentPayed","$installmentPicutre" );');
  }
}
