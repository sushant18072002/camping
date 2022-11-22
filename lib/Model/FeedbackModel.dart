/// iD : ""
/// name : ""
/// message : ""

class FeedbackModel {
  FeedbackModel({
      String? iD, 
      String? name, 
      String? message,}){
    _iD = iD;
    _name = name;
    _message = message;
}

  FeedbackModel.fromJson(dynamic json) {
    _iD = json['iD'];
    _name = json['name'];
    _message = json['message'];
  }
  String? _iD;
  String? _name;
  String? _message;
FeedbackModel copyWith({  String? iD,
  String? name,
  String? message,
}) => FeedbackModel(  iD: iD ?? _iD,
  name: name ?? _name,
  message: message ?? _message,
);
  String? get iD => _iD;
  String? get name => _name;
  String? get message => _message;


  set iDSet(String value) {
    _iD = value;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['message'] = _message;
    return map;
  }

  set nameSet(String value) {
    _name = value;
  }

  set messageSet(String value) {
    _message = value;
  }
}