class Instructions_Model {
  int Id;
  String title;
  String details;

  Instructions_Model(
      {required this.Id, required this.title, required this.details});

  static List<Instructions_Model> getUsers() {
    return <Instructions_Model>[
      Instructions_Model(
          Id: 1,
          title: "Make a Trip",
          details:
              "By pressing “start new trip” button \nyou’ll be able to make fill a form\nwhich will help you to set up your...."),
      Instructions_Model(
          Id: 2,
          title: "Add Location",
          details:
              "This app have a great feature which \nallows you to discover the top \nlocations around the world and le...."),
      Instructions_Model(
          Id: 3,
          title: "Add Teammates",
          details:
              "If you previously added teammates \nthey will show in the list. but is you \ndidn't do that you need to add n...."),
      Instructions_Model(
          Id: 4,
          title: "Now you’re Ready",
          details:
          "To begin your adventure with your\nCamping App which will helps you\nto set your targets. know what be...."),
    ];
  }
}
