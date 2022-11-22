class TripModel {
  TripModel({
    String? id,
    String? tripName,
    String? location,
    List<String>? teammates,
    String? pickDate,
  }) {
    _id = id;
    _tripName=tripName;
    _location = location;
    _teammates = teammates;
    _pickDate = pickDate;
  }

   TripModel.fromJson(dynamic json) {
    _id = json['id'];
    _tripName=json['tripName'];
    _location = json['location'];
    _teammates =
        json['teammates'] != null ? json['teammates'].cast<String>() : [];
    _pickDate = json['pickDate'];
  }

  String? _id;
  String? _tripName;
  String? _location;
  List<String>? _teammates;
  String? _pickDate;

  TripModel copyWith({
    String? id,
    String? tripName,
    String? location,
    List<String>? teammates,
    String? pickDate,
  }) =>
      TripModel(
        id: id ?? _id,
        tripName: _tripName,
        location: location ?? _location,
        teammates: teammates ?? _teammates,
        pickDate: pickDate ?? _pickDate,
      );

  String? get id => _id;
  String? get tripName => _tripName;

  String? get location => _location;

  List<String>? get teammates => _teammates;

  String? get pickDate => _pickDate;

  set idSet(String value) {
    _id = value;
  }
  set tripNameSet(String value) {
    _tripName = value;
  }

  set locationSet(String value) {
    _location = value;
  }

  set teammatesSet(List<String> value) {
    _teammates = value;
  }

  set pickDateSet(String value) {
    _pickDate = value;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if(_id!=null) {
      map['id']=_id;
    }
    map['tripName'] = _tripName;
    map['location'] = _location;
    map['teammates'] = _teammates;
    map['pickDate'] = _pickDate;
    return map;
  }

  Map<String, dynamic> toJsonId() {
    final map = <String, dynamic>{};
    map['id']=_id;
    map['tripName'] = _tripName;
    map['location'] = _location;
    map['teammates'] = _teammates;
    map['pickDate'] = _pickDate;
    return map;
  }
}
