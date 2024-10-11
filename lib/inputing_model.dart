class InputtingModel {
  int? _id;
  String? _date;
  String? _productName;
  double? _amount;
  int? _price;
  String? _seller;

  InputtingModel(
    this._date,
    this._productName,
    this._amount,
    this._price,
    this._seller,
  );

  int get id => _id!;
  String get date => _date!;
  String get productName => _productName!;
  double get amount => _amount!;
  int get price => _price!;
  String get seller => _seller!;

  set date(String newDate) {
    _date = date;
  }

  set productName(String newProduct) {
    _productName = productName;
  }

  set amount(double newAmount) {
    _amount = amount;
  }

  set price(int newPrice) {
    _price = price;
  }

  set seller(String newSeller) {
    _seller = seller;
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["date"] = _date;
    map["productName"] = _productName;
    map["amount"] = _amount;
    map["price"] = _price;
    map["seller"] = seller;

    return map;
  }

  InputtingModel.fromMapObject(Map<String, dynamic> map) {
    _id = map["id"];
    _date = map["date"];
    _productName = map["productName"];
    _amount = map["amount"];
    _price = map["price"];
    _seller = map["seller"];
  }
}
