/// id : ""
/// imagename : ""

class CatchSnapModel {
  CatchSnapModel({
      String? id, 
      String? imagename,}){
    _id = id;
    _imagename = imagename;
}

  CatchSnapModel.fromJson(dynamic json) {
    _id = json['id'];
    _imagename = json['imagename'];
  }
  String? _id;
  String? _imagename;
CatchSnapModel copyWith({  String? id,
  String? imagename,
}) => CatchSnapModel(  id: id ?? _id,
  imagename: imagename ?? _imagename,
);
  String? get id => _id;
  String? get imagename => _imagename;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['imagename'] = _imagename;
    return map;
  }

}