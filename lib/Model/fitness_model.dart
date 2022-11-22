class FitnessModel {
  int iD;
  String title;
  String image;
  int value;
  String unit;
  int percent;

  FitnessModel(
      {required this.iD,
  required this.image,
        required this.title,
        required this.value,
        required this.unit,
        required this.percent});

  static List<FitnessModel> getActivites() {
    return <FitnessModel>[
      FitnessModel(
          iD: 1,
          image:"",
          title: "Find a Place",
          value:0,
          unit:
          "",
          percent: 80),
      FitnessModel(
          iD: 2,
          image:"",
          title: "Going to Fishing",
          value:0,
          unit:
          "",
          percent: 90),
      FitnessModel(
          iD: 3,
          image:"",
          title: "Hiking on the mou....",
          value:0,
          unit:
          "",
          percent: 00),
    ];
  }
}
