import 'package:belal_pro/db/dbhelper.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class DbIncome {
  //     "oncome_id"	INTEGER NOT NULL,
  //     "odbincome.dartncome_date"	TEXT,
  //     "income_qty"	NUMERIC,
  //     "income_unitPrice"	NUMERIC,
  //     "income_currency"	TEXT DEFAULT 'شيكل',
  //     "income_currencyValue"	NUMERIC,
  //     "income_paymentMethod"	TEXT DEFAULT 'نقدي',
  //     "income_note"	TEXT,
  DbHelper dbHelper = DbHelper();

  Future<List<Map<String, Object?>>> allIncome() async {
    Database? db = await dbHelper.openDb();
    String sql = 'SELECT * from incomes';
    return db!.rawQuery(sql);
  }

  deleteIncome(int id) async {
    Database? db = await dbHelper.openDb();
    String sql = 'DELETE FROM incomes  WHERE income_id=$id';
    db!.rawQuery(sql);
  }

  Future<List<Map<String, Object?>>> ListImportNames() async {
    Database? db = await dbHelper.openDb();
    String sql = 'SELECT * from List_Import_Names';
    return db!.rawQuery(sql);
  }


  Future<void> addIncome(
      String income_date,
      int income_person_id,
      String income_person_name,
      int income_project_id,
      String income_project_type,
      String income_project_name,
      int income_value,
      String income_currency,
      int income_currencyValue,
      String income_paymentMethod,
      String income_note ) async {
    // "income_date"	TEXT DEFAULT '12/02/2023',
    // "income_person_id"	INTEGER DEFAULT 1,
    // "income_person_name"	TEXT DEFAULT 'بلال حرب',
    // "income_project_id"	INTEGER DEFAULT 1,
    // "income_project_type"	TEXT DEFAULT 'مشاريع',
    // "income_project_name"	TEXT DEFAULT 'كلية الرباط الجامعية',
    // "income_value"	NUMERIC DEFAULT 23,
    // "income_currency"	TEXT DEFAULT 'شيكل',
    // "income_currencyValue"	NUMERIC DEFAULT 3.50,
    // "income_paymentMethod"	TEXT DEFAULT 'نقدي',
    // "income_note"	TEXT,
    Database? db = await dbHelper.openDb();
    return db!.execute(                                                                                                                                                                                                          //    income_date,income_person_id,income_person_name          ,income_project_id,income_project_type,income_project_name,income_value,income_currency,income_currencyValue,income_paymentMethod,income_note
        'INSERT INTO incomes ( income_date,income_person_id,income_person_name,income_project_id,income_project_type,income_project_name,income_value,income_currency,income_currencyValue,income_paymentMethod,income_note ) VALUES ("$income_date","$income_person_id","$income_person_name","$income_project_id","$income_project_type","$income_project_name","$income_value","$income_currencyValue","$income_paymentMethod","$income_note" );');
  }
}
