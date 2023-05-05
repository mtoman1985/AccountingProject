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
class InstallmentsModel {
  int _id = 1;
  String _type = 'المشاريع';
  String _type_id = "mo";
  String _date = "mo";
  String _kind = "شيك";
  String _value = "0";
  String _currency = "شيكل";
  String _meritDate = "mo";
  String _payed = 'لا';
  String _picutre = "mo";
  String _installment_checkWallent_id="1";

  InstallmentsModel(dynamic obj) {
    _id = obj["installment_id"];
    _type = obj["installment_type"];
    _type_id = obj["installment_type_id"];
    _date = obj["installment_date"];
    _kind = obj["installment_kind"];
    _value = obj["installment_value"];
    _currency = obj["installment_currency"];
    _meritDate = obj["installment_meritDate"];
    _payed = obj["installment_payed"];
    _picutre = obj["installment_picutre"];
    _installment_checkWallent_id= obj["installment_checkWallent_id"];
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
  }

  InstallmentsModel.fromMap(Map<String, dynamic> data) {
    _id = data["installment_id"] as int;
    _type = data["installment_type"];
    _type_id = data["installment_type_id"];
    _date = data["installment_date"];
    _kind = data["installment_kind"];
    _value = data["installment_value"];
    _currency = data["installment_currency"];
    _meritDate = data["installment_meritDate"];
    _payed = data["installment_payed"];
    _picutre = data["installment_picutre"];
    _installment_checkWallent_id= data["installment_checkWallent_id"];
  }
  Map<String, dynamic> toMap() => {
    'installment_id': _id,
    'installment_type': _type,
    'installment_type_id': _type_id,
    'installment_date': _date,
    'installment_kind': _kind,
    'installment_value': _value,
    'installment_currency': _currency,
    'installment_meritDate': _meritDate,
    'installment_payed': _payed,
    'installment_picutre': _picutre,
    'installment_checkWallent_id': _installment_checkWallent_id
  };


  int get id => _id;
  String get picutre => _picutre;
  String get payed => _payed;
  String get meritDate => _meritDate;
  String get currency => _currency;
  String get value => _value;
  String get kind => _kind;
  String get date => _date;
  String get type_id => _type_id;
  String get type => _type;
  String get installment_checkWallent_id => _installment_checkWallent_id;

  set picutre(String value) {
    _picutre = value;
  }
  set payed(String value) {
    _payed = value;
  }
  set meritDate(String value) {
    _meritDate = value;
  }
  set currency(String value) {
    _currency = value;
  }
  set value(String value) {
    _value = value;
  }
  set kind(String value) {
    _kind = value;
  }
  set date(String value) {
    _date = value;
  }
  set type_id(String value) {
    _type_id = value;
  }
  set type(String value) {
    _type = value;
  }
  set id(int value) {
    _id = value;
  }
  set installment_checkWallent_id(String value) {
    _installment_checkWallent_id = value;
  }
}
