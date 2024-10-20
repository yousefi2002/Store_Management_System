class Sell {
  int? _id;
  String? _date;
  String? _productName;
  double? _amount;
  int? _price;
  String? _user;

  Sell(
    this._date,
    this._productName,
    this._amount,
    this._price,
    this._user,
  );

  int? get id => _id;
  String get date => _date!;
  String get productName => _productName!;
  double get amount => _amount!;
  int get price => _price!;
  String get user => _user!;

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

  set user(String newUser) {
    _user = user;
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["date"] = _date;
    map["pr_name"] = _productName;
    map["amount"] = _amount;
    map["price"] = _price;
    map["user"] = user;
    return map;
  }

  Sell.fromMapObject(Map<String, dynamic> map) {
    _id = map["id"];
    _date = map["date"];
    _productName = map["pr_name"];
    _amount = map["amount"];
    _price = map["price"];
    _user = map["user"];
  }

  @override
  String toString() {
    return "id= $_id, date = $_date";
  }
}
