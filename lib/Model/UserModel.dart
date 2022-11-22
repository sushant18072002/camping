class UserModel {

  UserModel({
      String? name, 
      String? email, 
      String? phoneNo,
    String? image,
      String? description,}){
    _name = name;
    _email = email;
    _image=image;
    _phoneNo = phoneNo;
    _description = description;
}

  UserModel.fromJson(dynamic json) {
    _name = json['name'];
    _email = json['email'];
    _phoneNo = json['phone_no'];
    _image=json['image'];
    _description = json['description'];
  }
  String? _name;
  String? _email;
  String? _image;
  String? _phoneNo;
  String? _description;
UserModel copyWith({  String? name,
  String? email,
  String? phoneNo,
  String? image,
  String? description,
}) => UserModel(  name: name ?? _name,
  email: email ?? _email,
  phoneNo: phoneNo ?? _phoneNo,
  image: image?? _image,
  description: description ?? _description,
);
  String? get name => _name;
  String? get email => _email;
  String? get phoneNo => _phoneNo;
  String? get image => _image;
  String? get description => _description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['email'] = _email;
    map['phone_no'] = _phoneNo;
    map['image']=_image;
    map['description'] = _description;
    return map;
  }

  set nameSet(String value) {
    _name = value;
  }
  set imageSet(String value) {
    _image = value;
  }


  set descriptionSet(String value) {
    _description = value;
  }

  set phoneNoSet(String value) {
    _phoneNo = value;
  }

  set emailSet(String value) {
    _email = value;
  }

}