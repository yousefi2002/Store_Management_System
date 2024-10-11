class InputtingModel {
  int? _id;
  String? _productName;
  String? _amount;

  InputtingModel(
      this._productName,
      this._amount,
      );

  int get id => _id!;
  String get productName => _productName!;
  String get amount => _amount!;

  set productName(String newDate) {
    _productName = productName;
  }

  set amount(String newProduct) {
    _amount = amount;
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["productName"] = _productName;
    map["amount"] = _amount;

    return map;
  }

  InputtingModel.fromMapObject(Map<String, dynamic> map) {
    _id = map["id"];
    _productName = map["productName"];
    _amount = map["amount"];
  }
}
