/// imageUrl : ""
/// title : ""
/// discription : ""

class TipsAndTricksModel {
  TipsAndTricksModel({
    String? iD,
      String? imageUrl, 
      String? title, 
      String? discription,}){
    _iD=iD;
    _imageUrl = imageUrl;
    _title = title;
    _discription = discription;
}

  TipsAndTricksModel.fromJson(dynamic json) {
    _imageUrl = json['imageUrl'];
    _title = json['title'];
    _discription = json['discription'];
  }
  String? _imageUrl;
  String? _iD;
  String? _title;
  String? _discription;
TipsAndTricksModel copyWith({  String? imageUrl,
  String? title,
  String? discription,
}) => TipsAndTricksModel(  imageUrl: imageUrl ?? _imageUrl,
  title: title ?? _title,
  discription: discription ?? _discription,
);
  String? get iD => _iD;
  String? get imageUrl => _imageUrl;
  String? get title => _title;
  String? get discription => _discription;

  set imageUrlSet(String value) {
    _imageUrl = value;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['imageUrl'] = _imageUrl;
    map['title'] = _title;
    map['discription'] = _discription;
    return map;
  }

  set iDSet(String value) {
    _iD = value;
  }

  set titleSet(String value) {
    _title = value;
  }

  set discriptionSet(String value) {
    _discription = value;
  }
}