class Product {
  int? _id;
  String? _productName;

  Product(
      this._productName,
      );

  int? get id => _id;
  String get productName => _productName!;

  set productName(String newDate) {
    _productName = productName;
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["product_name"] = _productName;

    return map;
  }

  Product.fromMapObject(Map<String, dynamic> map) {
    _id = map["id"];
    _productName = map["product_name"];
  }
  @override
  String toString() {
    return 'name : $_productName';
  }
}
