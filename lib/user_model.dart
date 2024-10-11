class InputtingModel {
  int? _id;
  String? _sellerName;
  String? _phoneNumber;

  InputtingModel(
    this._sellerName,
    this._phoneNumber,
  );

  int get id => _id!;
  String get sellerName => _sellerName!;
  String get phoneNumber => _phoneNumber!;

  set sellerName(String newDate) {
    _sellerName = sellerName;
  }

  set phoneNumber(String newProduct) {
    _phoneNumber = phoneNumber;
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["sellerName"] = _sellerName;
    map["phoneNumber"] = _phoneNumber;

    return map;
  }

  InputtingModel.fromMapObject(Map<String, dynamic> map) {
    _id = map["id"];
    _sellerName = map["sellerName"];
    _phoneNumber = map["phoneNumber"];
  }
}
