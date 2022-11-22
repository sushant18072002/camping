class BackPackModel {
  int iD;
  String title;
  String image;

  BackPackModel(
      {required this.iD, required this.title,required this.image});

  static List<BackPackModel> getItems() {
    return <BackPackModel>[
      BackPackModel(
        iD: 1,
        title: "Pillow",
      image: "assets/icons/Pillows.png"),
      BackPackModel(
        iD: 2,
        title: "Sleeping Bag",
      image: "assets/icons/Sleeping_Bag.png"),
      BackPackModel(
        iD: 3,
        title: "Tent",
      image: "assets/icons/Tent.png"),
      BackPackModel(
        iD: 4,
        title: "AAA Batteries",
      image: "assets/icons/AAABatteries.png"),
      BackPackModel(
        iD: 5,
        title: "Shoes",
      image: "assets/icons/Shoes.png"),
      BackPackModel(
          iD: 6,
          title: "Camera",
          image: "assets/icons/Camera.png"),
      BackPackModel(
          iD: 7,
          title: "Charger",
          image: "assets/icons/Charger.png"),
    ];
  }
}
