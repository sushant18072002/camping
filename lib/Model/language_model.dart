class Langauge_Model {
  int iD;
  String langauge;

  Langauge_Model(
      {required this.iD, required this.langauge});

  static List<Langauge_Model> getUsers() {
    return <Langauge_Model>[
      Langauge_Model(
          iD: 1,
        langauge: "English",),
      Langauge_Model(
          iD: 2,
        langauge: "ودُراُ",
      ),
      Langauge_Model(
          iD: 3,
        langauge: "हिंदी",
      ),
      Langauge_Model(
          iD: 4,
        langauge: "Español",
      ),
      Langauge_Model(
        iD: 5,
        langauge: "Deutsche",
      ),
    ];
  }
}
