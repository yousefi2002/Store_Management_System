class User {
  int? _id;
  String? _userName;
  String? _userLastName;
  String? _phoneNumber;

  User(
    this._userName,
    this._userLastName,
    this._phoneNumber,
  );

  int? get id => _id;
  String get userName => _userName ?? '';
  String get userLastName => _userLastName ?? '';
  String get phoneNumber => _phoneNumber ?? '';

  set userName(String newName) {
    _userName = userName;
  }

  set userLastName(String newLastName) {
    _userName = userLastName;
  }

  set phoneNumber(String newPhoneNumber) {
    _phoneNumber = phoneNumber;
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["user_name"] = _userName;
    map["user_last_name"] = _userLastName;
    map["phone_number"] = _phoneNumber;

    return map;
  }

  User.fromMapObject(Map<String, dynamic> map) {
    _id = map["id"];
    _userName = map["user_name"];
    _userLastName = map["user_last_name"];
    _phoneNumber = map["phone_number"];
  }
  @override
  String toString() {
    return 'id = $_id, name = $_userName, user last name: $_userLastName, phone number: $_phoneNumber';
  }
}
