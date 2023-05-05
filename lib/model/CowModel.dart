class CowModel {
  // "cow_id"	INTEGER NOT NULL,
  // "cow_whight"	INTEGER DEFAULT 2000,
  // "cow_price_killo"	INTEGER DEFAULT 30,
  // "cow_total_price"	INTEGER DEFAULT 6000,
  // "cow_total"	INTEGER,
  // "cow_currency"	TEXT DEFAULT 'شيكل',
  // "cow_person_id"	TEXT DEFAULT '1-2-3',
  // "cow_person_name"	TEXT,
  // "cow_paymentMethod"	TEXT,
  // "cow_note"	TEXT,

  int _CowId = 1; //cow_id
  String _CowWhight = "03/03/2023"; //cow_whight
  String _CowPriceKillo= "شاومي"; //cow_price_killo
  int _CowTotalPrice = 5000;//cow_total_price
  String _CowTotal = "شيكل"; //cow_total
  int _CowCurrency = 500; //cow_currency
  int _CowPersonId = 100; //cow_person_id
  int _CowPersonName = 5; //cow_person_name
  String _CowPaymentMethod = " حعلز دسةس"; //cow_paymentMethod
  String _CowNote = " حعلز دسةس"; //cow_note
  CowModel(dynamic obj) {
    _CowId = obj["cow_id"]; //cow_id
    _CowWhight = obj["cow_whight"]; //cow_whight
    _CowPriceKillo = obj["cow_price_killo"]; //cow_price_killo
    _CowTotalPrice = obj["cow_total_price"]; //cow_total_price
    _CowTotal = obj["cow_total"]; //cow_total
    _CowCurrency = obj["cow_currency"]; //_cow_currency
    _CowPersonId = obj["cow_person_id"]; //cow_person_id
    _CowPersonName = obj["cow_note"]; //jawal_note
    _CowPaymentMethod = obj["cow_paymentMethod"]; //cow_paymentMethod
    _CowNote = obj["cow_note"]; //jawal_note
  }

  CowModel.fromMap(Map<String, dynamic> data) {
    _CowId = data["cow_id"]; //cow_id
    _CowWhight = data["cow_whight"]; //cow_whight
    _CowPriceKillo = data["cow_price_killo"]; //cow_price_killo
    _CowTotalPrice = data["cow_total_price"]; //cow_total_price
    _CowTotal = data["cow_total"]; //cow_total
    _CowCurrency = data["cow_currency"]; //_cow_currency
    _CowPersonId = data["cow_person_id"]; //cow_person_id
    _CowPersonName = data["jawal_note"]; //jawal_note
    _CowPaymentMethod = data["cow_paymentMethod"]; //cow_paymentMethod
    _CowNote = data["jawal_note"]; //jawal_note
  }

  Map<String, dynamic> toMap() => {
    'cow_id': _CowId, //cow_id
    'cow_whight': _CowWhight, //cow_whight
    'cow_price_killo': _CowPriceKillo, //cow_price_killo
    'cow_total_price': _CowTotalPrice, //cow_total_price
    'cow_total': _CowTotal, //cow_total
    'cow_currency': _CowCurrency, //_cow_currency
    'cow_person_id': _CowPersonId, //cow_person_id
    'jawal_note': _CowNote, //jawal_note,
    'cow_paymentMethod': _CowPaymentMethod, //cow_paymentMethod
    'jawal_note': _CowNote //jawal_note
  };

}
