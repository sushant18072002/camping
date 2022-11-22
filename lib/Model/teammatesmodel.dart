class TeammatesModel {
  int iD;
  String name;
  String image;
  String profile;
  int rating;
  String discription;

  TeammatesModel(
      {required this.iD,
        required this.name,
        required this.image,
        required this.profile,
        required this.rating,
        required this.discription,});

  static List<TeammatesModel> getActivites() {
    return <TeammatesModel>[
      TeammatesModel(
          iD: 1,
          name: "Chandler Hallow",
          image: "assets/images/ChandlerHallow.png",
          profile: "Chef",
          rating: 3,
          discription:
          "I’m a Chef and I assist in prep work, such as chopping vegetables, but more often will be involved in cooking specialty dishes. Chooses ingredients and designs a menu based on the seasonal availability of food items. Creates unique dishes that inspire guests to come back again and again to see what is new in the restaurant.",
         ),
      TeammatesModel(
          iD: 2,
          name: "Emma Linch",
          image:"assets/images/EmmaLinch.png",
          profile: "Environment Expert",
          rating: 4,
          discription:
          "I’m a Chef and I assist in prep work, such as chopping vegetables, but more often will be involved in cooking specialty dishes. Chooses ingredients and designs a menu based on the seasonal availability of food items. Creates unique dishes that inspire guests to come back again and again to see what is new in the restaurant.",
          ),
      TeammatesModel(
          iD: 3,
          name: "Mike Alen",
          profile: "Farmer",
          image: "assets/images/MikeAlen.png",
          rating: 5,
          discription:
          "I’m a Chef and I assist in prep work, such as chopping vegetables, but more often will be involved in cooking specialty dishes. Chooses ingredients and designs a menu based on the seasonal availability of food items. Creates unique dishes that inspire guests to come back again and again to see what is new in the restaurant.",
          ),
      TeammatesModel(
          iD: 4,
          name: "You",
          profile: "Web Developer",
          image: "assets/images/Avatarrectangle.png",
          rating: 1,
          discription:
          "I’m a Chef and I assist in prep work, such as chopping vegetables, but more often will be involved in cooking specialty dishes. Chooses ingredients and designs a menu based on the seasonal availability of food items. Creates unique dishes that inspire guests to come back again and again to see what is new in the restaurant.",
          ),
    ];
  }
}
