class Expenses {
  int? _id;
  String? _date;
  String? _reasonToSpend;
  int? _amountToSpend;

  Expenses(
    this._date,
    this._reasonToSpend,
    this._amountToSpend,
  );

  int? get id => _id;
  String get date => _date!;
  String get reasonToSpend => _reasonToSpend ?? '';
  int get amountToSpend => _amountToSpend ?? 0;

  set date(String newDate) {
    _date = date;
  }
  set reasonToSpend(String newReason) {
    _reasonToSpend = reasonToSpend;
  }
  set amountToSpend(int newAmount) {
    _amountToSpend = amountToSpend;
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["date"] = _date;
    map["reason_to_spend"] = _reasonToSpend;
    map["amount_to_spend"] = _amountToSpend;

    return map;
  }

  Expenses.fromMapObject(Map<String, dynamic> map) {
    _id = map["id"];
    _date = map["date"];
    _reasonToSpend = map["reason_to_Spend"];
    _amountToSpend = map["amount_to_Spend"];
  }
  @override
  String toString() {
    return 'id = $_id, reason = $_reasonToSpend date: $date ,  spent: $amountToSpend';
  }
}
