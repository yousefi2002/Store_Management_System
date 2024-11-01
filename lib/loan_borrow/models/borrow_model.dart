
class Borrow{
  int? _borrowId;
  String? _borrowDate;
  String? _borrowReason;
  int? _borrowAmount;

  Borrow(this._borrowDate, this._borrowReason, this._borrowAmount);

  int? get borrowId => _borrowId;
  String get borrowDate => _borrowDate!;
  String get borrowReason =>  _borrowReason ?? '';
  int get borrowAmount => _borrowAmount ?? 0;

  set borrowDate(String newDate){
    _borrowDate = borrowDate;
  }
  set borrowReason(String newReason){
    _borrowReason = borrowReason;
  }
  set borrowAmount(int newAmount){
    _borrowAmount = borrowAmount;
  }

  Map<String, dynamic> toMap(){
    var map = <String, dynamic>{};
    map['id'] = _borrowId;
    map['date'] = _borrowDate;
    map['reason'] = _borrowReason;
    map['amount'] = _borrowAmount;

    return map;
  }

  Borrow.fromMapObject(Map<String, dynamic> map){
    _borrowId = map['id'];
    _borrowDate = map['date'];
    _borrowReason = map['reason'];
    _borrowAmount = map['amount'];
  }

  @override
  String toString() {
    return 'id = $_borrowId , reason = $_borrowReason , amount = $_borrowAmount';
  }
}