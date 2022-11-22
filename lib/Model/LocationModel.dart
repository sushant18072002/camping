/// iD : ""
/// title : ""
/// location : ""
/// region : ""
/// image : ""
/// discription : ""

class LocationModel {
  LocationModel({
      String? iD, 
      String? title, 
      String? location, 
      String? region, 
      String? image, 
      String? discription,}){
    _iD = iD;
    _title = title;
    _location = location;
    _region = region;
    _image = image;
    _discription = discription;
}

  LocationModel.fromJson(dynamic json) {
    _title = json['title'];
    _location = json['location'];
    _region = json['region'];
    _image = json['image'];
    _discription = json['discription'];
  }
  String? _iD;
  String? _title;
  String? _location;
  String? _region;
  String? _image;
  String? _discription;
LocationModel copyWith({  String? iD,
  String? title,
  String? location,
  String? region,
  String? image,
  String? discription,
}) => LocationModel(  iD: iD ?? _iD,
  title: title ?? _title,
  location: location ?? _location,
  region: region ?? _region,
  image: image ?? _image,
  discription: discription ?? _discription,
);
  String? get iD => _iD;
  String? get title => _title;
  String? get location => _location;
  String? get region => _region;
  String? get image => _image;
  String? get discription => _discription;


  set iDSet(String value) {
    _iD = value;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = _title;
    map['location'] = _location;
    map['region'] = _region;
    map['image'] = _image;
    map['discription'] = _discription;
    return map;
  }

  set titleSet(String value) {
    _title = value;
  }

  set locationSet(String value) {
    _location = value;
  }

  set regionSet(String value) {
    _region = value;
  }

  set imageSet(String value) {
    _image = value;
  }

  set discriptionSet(String value) {
    _discription = value;
  }
}