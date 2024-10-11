class InputtingModel {
  int? _id;
  String? _date;
  String? _reasonToSpend;
  double? _amountToSpend;

  InputtingModel(
    this._date,
    this._reasonToSpend,
    this._amountToSpend,
  );

  int get id => _id!;
  String get date => _date!;
  String get reasonToSpend => _reasonToSpend!;
  double get amountToSpend => _amountToSpend!;

  set date(String newDate) {
    _date = date;
  }

  set reasonToSpend(String newProduct) {
    _reasonToSpend = reasonToSpend;
  }

  set amountToSpend(double newAmount) {
    _amountToSpend = amountToSpend;
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["date"] = _date;
    map["reasonToSpend"] = _reasonToSpend;
    map["amountToSpend"] = _amountToSpend;

    return map;
  }

  InputtingModel.fromMapObject(Map<String, dynamic> map) {
    _id = map["id"];
    _date = map["date"];
    _reasonToSpend = map["reasonToSpend"];
    _amountToSpend = map["amountToSpend"];
  }
}
