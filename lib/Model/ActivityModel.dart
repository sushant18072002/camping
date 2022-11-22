
class ActivityModel {
  ActivityModel({
    String? id,
    String? heading,
    String? description,
    String? author,
    bool? isComplete,}) {
    _id = id;
    _heading = heading;
    _description = description;
    _author = author;
    _isComplete = isComplete;
  }

  ActivityModel.fromJson(dynamic json) {
    _id = json['id'];
    _heading = json['heading'];
    _description = json['description'];
    _author = json['author'];
    _isComplete = json['isComplete'];
  }

  String? _id;
  String? _heading;
  String? _description;
  String? _author;
  bool? _isComplete;

  ActivityModel copyWith({ String? id,
    String? heading,
    String? description,
    String? author,
    bool? isComplete,
  }) =>
      ActivityModel(
        id: id ?? _id,
        heading: heading ?? _heading,
        description: description ?? _description,
        author: author ?? _author,
        isComplete: isComplete ?? _isComplete,
      );

  String? get id => _id;

  String? get heading => _heading;

  String? get description => _description;

  String? get author => _author;

  bool? get isComplete => _isComplete;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['heading'] = _heading;
    map['description'] = _description;
    map['author'] = _author;
    map['isComplete'] = _isComplete ?? false;
    return map;
  }

  set idSet(String value) {
    _id = value;
  }


  set headingSet(String value) {
    _heading = value;
  }

  set descriptionSet(String value) {
    _description = value;
  }

  set authorSet(String value) {
    _author = value;
  }

  set isCompleteSet(bool value) {
    _isComplete = value;
  }

  static List<ActivityModel> getActivites() {
    return <ActivityModel>[
      ActivityModel(
        heading: "Find a Place",
        description:
        "We need to find a perfect place for set up our camp’s and where we will...",
        author: "you",
        isComplete: false,
      ),
      ActivityModel(
        heading: "Going to Fishing",
        description:
        "We need to find out our tomorrow’s breakfast. I mean the delicious fish...",
        author: "Emma",
        isComplete: false,
      ),
      ActivityModel(
        heading: "Hiking on the mou....",
        description:
        "Tomorrow we need to wake up early for hiking on that big mountain. It wil....",
        author: "Chandler",
        isComplete:false,
      ),
      ActivityModel(
        heading: "View of the sunset",
        description:
        "Out side of that ridge we will see the beautiful sunset. ",
        author: "Emma",
        isComplete: false,
      ),
    ];
  }
}