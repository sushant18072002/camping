class TipAndTrickModel{
  int id;
  String image;
  String tips;
  String tricks;
  TipAndTrickModel(this.id, this.image, this.tips, this.tricks);
  static List<TipAndTrickModel> getData(){
    return <TipAndTrickModel>[
      TipAndTrickModel(0, "assets/images/TipAndTrickModel1.png", "Use these camping tips, tricks and hacks to make yo..", "Camping connects you with the quiet majesty of nature, allowing...."),
      TipAndTrickModel(1, "assets/images/TipAndTrickModel2.png", "These camping food hacks will definately make your c....", "As everyone knows that making food is always hard when you do..."),
      TipAndTrickModel(2, "assets/images/TipAndTrickModel3.png", "Top ten must carry equipments for your next c....", "In this tip we have a list of compulsary taken equipments for..."),
      TipAndTrickModel(3, "assets/images/TipAndTrickModel4.png", "Make a lantern out of a headlamp and a jug of wat...", "All you need is your headlamp and a gallon jug of water or large wat...."),
      TipAndTrickModel(4, "assets/images/TipAndTrickModel5.png", "Line your bag with a garbage bag to keep contents dry", "Weather is everything when you’re camping, and a seasoned campe..."),
      TipAndTrickModel(5, "assets/images/TipAndTrickModel6.png", "Make a Makeshift Grommet by Tying Line Around a Roc...", "Tarp grommets wear out quickly and often when you need them...."),
      TipAndTrickModel(6, "assets/images/TipAndTrickModel7.png", "Burn Sage in Your Campfire to Help Repel Mosquitoes", "Mosquitoes can dampen an otherwise great camping experience. Knowing "),
    ];
  }
}