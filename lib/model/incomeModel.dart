class IncomeModel {
  // "income_id"	INTEGER NOT NULL DEFAULT 1,
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
  int _id = 1;
  String _date = "21/12/2022";
  int _person_id = 1;
  String _person_name = 'بلال حرب';
  int _project_id = 1;
  String _project_type='مشاريع';
  String _project_name= 'كلية الرباط الجامعية';
  int _value = 300;
  String _currency = "شيكل";
  double _currencyValue = 1.0;
  String _paymentMethod = "نقدي";
  String _note = 'الصادر';

  IncomeModel(dynamic obj) {
    _id = obj["income_id"];
    _date = obj["income_date"];
    _person_id = obj["income_person_id"];
    _person_name = obj["income_person_name"];
    _project_id = obj["income_project_id"];
    _project_type = obj["income_project_type"];
    _project_name = obj["income_project_name"];
    _value = obj["income_value"];
    _currency = obj["income_currency"];
    _currencyValue = obj["income_currencyValue"];
    _paymentMethod = obj["income_paymentMethod"];
    _note = obj["income_note"];
  }
  IncomeModel.fromMap(Map<String, dynamic> data) {
    _id = data["income_id"] ;
    _date = data["income_date"].toString();
    _person_id =int.parse( data["income_person_id"].toString());
    _person_name = data["income_person_name"].toString();
    _project_id = int.parse(data["income_project_id"].toString());
    _project_type = data["income_project_type"].toString();
    _project_name = data["income_project_name"].toString();
    _value =int.parse( data["income_value"].toString() );
    _currency = data["income_currency"].toString() ;
    _currencyValue = double.parse( data["income_currencyValue"].toString());
    _paymentMethod = data["income_paymentMethod"].toString();
    _note = data["income_note"].toString();
  }
  Map<String, dynamic> toMap() => {
    "income_id":_id,
    "income_date" :_date  ,
    "income_person_id":_person_id  ,
    "income_person_name":_person_name  ,
    "income_project_id" :_project_id ,
    "income_project_type" :_project_type ,
    "income_project_name" :_project_name ,
    "income_value" :_value  ,
    "income_currency" : _currency,
    "income_currencyValue" :_currencyValue  ,
    "income_paymentMethod":_paymentMethod ,
    "income_note" : _note ,
  };

  String get person_name => _person_name;

  set person_name(String value) {
    _person_name = value;
  }

  String get note => _note;

  set note(String value) {
    _note = value;
  }

  String get paymentMethod => _paymentMethod;

  set paymentMethod(String value) {
    _paymentMethod = value;
  }

  double get currencyValue => _currencyValue;

  set currencyValue(double value) {
    _currencyValue = value;
  }

  String get currency => _currency;

  set currency(String value) {
    _currency = value;
  }

  int get value => _value;

  set value(int value) {
    _value = value;
  }

  int get project_id => _project_id;

  set project_id(int value) {
    _project_id = value;
  }

  int get person_id => _person_id;

  set person_id(int value) {
    _person_id = value;
  }

  String get date => _date;

  set date(String value) {
    _date = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  String get project_type => _project_type;

  String get project_name => _project_name;

  set project_name(String value) {
    _project_name = value;
  }

  set project_type(String value) {
    _project_type = value;
  }
}
