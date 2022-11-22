class SignupModel {
  String? id;
  String? name;
  String? email;
  String? phoneNo;
  String? password;
  String? description;

  SignupModel({
    this.id,
    this.name,
    this.email,
    this.phoneNo,
    this.password,
    this.description,
  });

  SignupModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneNo = json['phone_no'];
    password = json['password'];
    description=json['description'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['email'] = email;
    map['phone_no'] = phoneNo;
    map['description']=description;
    return map;
  }
}
