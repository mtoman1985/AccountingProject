class JawalModel {
  // "jawal_id"	INTEGER NOT NULL,
  // "jawal_start_date"	TEXT,
  // "jawal_type"	INTEGER,
  // "jawal_value"	INTEGER,
  // "jawal_currency"	TEXT,
  // "jawal_first_payment"	INTEGER,
  // "jawal_penfit_value"	INTEGER,
  // "jawal_total_value"	INTEGER,
  // "jawal_note"	TEXT,
  int _JawalId = 1; //jawal_id
  String _JawalStartDate = "03/03/2023"; //jawal_start_date
  String _JawalType= "شاومي"; //jawal_type
  int _JawalValue = 5000;//jawal_value
  String _JawalCurrency = "شيكل"; //jawal_currency
  int _JawalSFirstPayment = 500; //jawal_first_payment
  int _JawalPenfitValue = 100; //jawal_penfit_value
  int _JawalTotalValue = 5; //jawal_total_value
  String _JawalNote = " حعلز دسةس"; //jawal_note
  JawalModel(dynamic obj) {
    _JawalId = obj["jawal_id"]; //jawal_id
    _JawalStartDate = obj["jawal_start_date"]; //jawal_start_date
    _JawalType = obj["jawal_type"]; //jawal_type
    _JawalValue = obj["jawal_value"]; //jawal_value
    _JawalCurrency = obj["jawal_currency"]; //jawal_currency
    _JawalSFirstPayment = obj["jawal_first_payment"]; //jawal_first_payment
    _JawalPenfitValue = obj["jawal_penfit_value"]; //jawal_penfit_value
    _JawalTotalValue = obj["jawal_total_value"]; //jawal_total_value
    _JawalNote = obj["jawal_note"]; //jawal_note
  }

  JawalModel.fromMap(Map<String, dynamic> data) {
    _JawalId = data["jawal_id"]; //jawal_id
    _JawalStartDate = data["jawal_start_date"]; //jawal_start_date
    _JawalType = data["jawal_type"]; //jawal_type
    _JawalValue = data["jawal_value"]; //jawal_value
    _JawalCurrency = data["jawal_currency"]; //jawal_currency
    _JawalSFirstPayment = data["jawal_first_payment"]; //jawal_first_payment
    _JawalPenfitValue = data["jawal_penfit_value"]; //jawal_penfit_value
    _JawalTotalValue = data["jawal_total_value"]; //jawal_total_value
    _JawalNote = data["jawal_note"]; //jawal_note
  }

  Map<String, dynamic> toMap() => {
    'jawal_id': _JawalId, //jawal_id
    'jawal_start_date': _JawalStartDate, //jawal_start_date
    'jawal_type': _JawalType, //jawal_type
    'jawal_value': _JawalValue, //jawal_value
    'jawal_currency': _JawalCurrency, //jawal_currency
    'jawal_first_payment': _JawalSFirstPayment, //jawal_first_payment
    'jawal_penfit_value': _JawalPenfitValue, //jawal_penfit_value
    'jawal_total_value': _JawalTotalValue, //jawal_total_value
    'jawal_note': _JawalNote //jawal_note
  };

  String get JawalNote => _JawalNote;

  set JawalNote(String value) {
    _JawalNote = value;
  }

  int get JawalTotalValue => _JawalTotalValue;

  set JawalTotalValue(int value) {
    _JawalTotalValue = value;
  }

  int get JawalPenfitValue => _JawalPenfitValue;

  set JawalPenfitValue(int value) {
    _JawalPenfitValue = value;
  }

  int get JawalSFirstPayment => _JawalSFirstPayment;

  set JawalSFirstPayment(int value) {
    _JawalSFirstPayment = value;
  }

  String get JawalCurrency => _JawalCurrency;

  set JawalCurrency(String value) {
    _JawalCurrency = value;
  }

  int get JawalValue => _JawalValue;

  set JawalValue(int value) {
    _JawalValue = value;
  }

  String get JawalType => _JawalType;

  set JawalType(String value) {
    _JawalType = value;
  }

  String get JawalStartDate => _JawalStartDate;

  set JawalStartDate(String value) {
    _JawalStartDate = value;
  }

  int get JawalId => _JawalId;

  set JawalId(int value) {
    _JawalId = value;
  }
}
