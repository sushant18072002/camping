class NoticationModel {
  int id;
  String image;
  String title;
  String discription;

  NoticationModel(this.id, this.image, this.title, this.discription);

  static List<NoticationModel> getData() {
    return <NoticationModel>[
      NoticationModel(1, "assets/icons/checkmarkgreen.png", "Congratulations!", "You recieved the welcome badge"),
      NoticationModel(2, "assets/icons/alert-circle.png", "You didn’t completed the activity.", "Named view of sunset by Emma."),
      NoticationModel(3, "assets/icons/checkMark.png", "You completed an activity", "Named Hiking on mountain by Chandler.")
    ];
  }
}
