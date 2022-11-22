class BagItemModel {
  BagItemModel({
    String? id,
    bool? isCheck,
    String? item,
    num? count,
  }) {
    _id = id;
    _isCheck = isCheck;
    _item = item;
    _count = count;
  }

  BagItemModel.fromJson(dynamic json) {
    _id = json['id'];
    _isCheck = json['isCheck'];
    _item = json['item'];
    _count = json['count'];
  }

  String? _id;
  bool? _isCheck;
  String? _item;
  num? _count;

  BagItemModel copyWith({
    String? id,
    bool? isCheck,
    String? item,
    num? count,
  }) =>
      BagItemModel(
        id: id ?? _id,
        isCheck: isCheck ?? _isCheck,
        item: item ?? _item,
        count: count ?? _count,
      );

  String? get id => _id;

  bool? get isCheck => _isCheck;

  String? get item => _item;

  num? get count => _count;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['item'] = _item;
    map['count'] = _count;
    return map;
  }

  set idSet(String value) {
    _id = value;
  }


  set isCheckSet(bool value) {
    _isCheck = value;
  }

  set itemSet(String value) {
    _item = value;
  }

  set countSet(num value) {
    _count = value;
  }

  static List<BagItemModel> getUsers() {
    return <BagItemModel>[
      BagItemModel(item: "Sleeping Bag",isCheck: false,count: 0),
      BagItemModel(item: "Pillow", isCheck: false,count: 0),
      BagItemModel(
          item: "Sleeping mat or camp bed (If tent camping)",
          isCheck: false,count: 0),
      BagItemModel(
           item: "Mallet, spare pegs and puller", isCheck: false,count: 0),
      BagItemModel(
          item: "Spare batteries, portable charger and cables",
          isCheck: false,count: 0),
      BagItemModel(item: "Torch and head torch", isCheck: false,count: 0),
      BagItemModel(item: "Tent repair kit", isCheck: false,count: 0),
      BagItemModel(item: "Paracord", isCheck: false,count: 0),
      BagItemModel(item: "Gaffa tape", isCheck: false,count: 0),
      BagItemModel(item: "Cable ties", isCheck: false,count: 0),
      BagItemModel(item: "Sewing kit", isCheck: false,count: 0),
      BagItemModel(item: "Lantern", isCheck: false,count: 0),
    ];
  }
}


