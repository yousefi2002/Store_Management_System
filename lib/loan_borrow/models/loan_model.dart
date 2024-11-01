
class Loan{
  int? _id;
  String? _date;
  String? _reason;
  int? _amount;

  Loan(this._date, this._reason, this._amount);

  int? get id => _id;
  String get date => _date!;
  String get reason =>  _reason ?? '';
  int get amount => _amount ?? 0;

  set date(String newDate){
    _date = date;
  }
  set reason(String newReason){
    _reason = reason;
  }
  set amount(int newAmount){
    _amount = amount;
  }

  Map<String, dynamic> toMap(){
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['date'] = _date;
    map['reason'] = _reason;
    map['amount'] = _amount;

    return map;
  }

  Loan.fromMapObject(Map<String, dynamic> map){
    _id = map['id'];
    _date = map['date'];
    _reason = map['reason'];
    _amount = map['amount'];
  }

  @override
  String toString() {
    return 'id = $_id , reason = $_reason , amount = $_amount';
  }
}