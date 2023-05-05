class OutcometModel {
  // "outcome_id"	INTEGER NOT NULL,
  // "outcome_date"	TEXT DEFAULT '22/03/2023',
  // "outcome_person_id"	INTEGER DEFAULT 1,
  // "outcome_person_name"	TEXT DEFAULT 'بلال حرب',
  // "outcome_project_id"	INTEGER DEFAULT 1,
  // "outcome_project_type"	TEXT DEFAULT 'مشاريع',
  // "outcome_project_name"	TEXT DEFAULT 'كلية الرباط الجامعية',
  // "outcome_value"	NUMERIC DEFAULT 3000,
  // "outcome_currency"	TEXT DEFAULT 'شيكل',
  // "outcome_currencyValue"	NUMERIC DEFAULT 3.5,
  // "outcome_paymentMethod"	TEXT DEFAULT 'نقدي',
  // "outcome_note"	TEXT,
  int _id = 1;
  String _date = "21/12/2022";
  int _person_id = 1;
  String _person_name = 'بلال حرب';
  int _project_id = 1;
  String _project_type = 'مشاريع';
  String _project_name = 'كلية الرباط الجامعية';
  int _value = 300;
  String _currency = "شيكل";
  double _currencyValue = 1.0;
  String _paymentMethod = "نقدي";
  String _note = 'الصادر';

  OutcometModel(dynamic obj) {
    _id = obj["outcome_id"];
    _date = obj["outcome_date"];
    _person_id = obj["outcome_person_id"];
    _person_name = obj["outcome_person_name"];
    _project_id = obj["outcome_project_id"];
    _project_type = obj["outcome_project_type"];
    _project_name = obj["outcome_project_name"];
    _value = obj["outcome_value"];
    _currency = obj["outcome_currency"];
    _currencyValue = obj["outcome_currencyValue"];
    _paymentMethod = obj["outcome_paymentMethod"];
    _note = obj["outcome_note"];
  }
  OutcometModel.fromMap(Map<String, dynamic> data) {
    _id = data["outcome_id"];
    _date = data["outcome_date"];
    _person_id = data["outcome_person_id"];
    _person_name = data["outcome_person_name"];
    _project_id = data["outcome_project_id"];
    _project_type = data["outcome_project_type"];
    _project_name = data["outcome_project_name"];
    _value = data["outcome_value"];
    _currency = data["outcome_currency"];
    _currencyValue = data["outcome_currencyValue"];
    _paymentMethod = data["outcome_paymentMethod"];
    _note = data["outcome_note"];
  }
  Map<String, dynamic> toMap() => {
    "outcome_id":_id,
    "outcome_date" :_date  ,
    "outcome_person_id":_person_id  ,
    "outcome_person_name":_person_name  ,
    "outcome_project_id" :_project_id ,
    "outcome_project_type" :_project_type ,
    "outcome_project_name" :_project_name ,
    "outcome_value" :_value  ,
    "outcome_currency" : _currency,
    "outcome_currencyValue" :_currencyValue  ,
    "outcome_paymentMethod":_paymentMethod ,
    "outcome_note" : _note ,
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
