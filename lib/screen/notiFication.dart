import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:task2/CustumWidget/appbarutilies.dart';
import 'package:task2/Utilities/color_manager.dart';
import 'package:task2/Utilities/dimension_manager.dart';
import 'package:task2/Utilities/style_manager.dart';
import 'package:task2/screen/sign_up.dart';

class NotiFication extends KFDrawerContent {
  @override
  State<NotiFication> createState() => _NotiFicationState();
}

class _NotiFicationState extends State<NotiFication> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBarUtilies.AppbarWithGrid("Notifications", widget.onMenuPressed),
      backgroundColor: ColorManager.white,
      body: bodyUi(),
    );
  }

  Widget bodyUi() {
    return Padding(
      padding: DimensionManager.fromLTRB(20, 0, 20),
      child: Column(
        children: [
          Container(
              margin: DimensionManager.topAndBottom(15, 16),
              child: Text(
                "11 Feb 2020",
                style: TextStyle(
                    color: ColorManager.colorA1A1AA,
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              )),
          Container(
            alignment: Alignment.center,
            padding: DimensionManager.all(16),
            decoration: BoxDecoration(
              color: ColorManager.f7FEE7,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: DimensionManager.divH(48),
                  width: DimensionManager.divW(48),
                  decoration: BoxDecoration(
                    color: ColorManager.containerBackground12,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(15.0),

                    /*
                         RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  )
                         */
                  ),
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/icons/award.png",
                    height: DimensionManager.divH(20),
                    width: DimensionManager.divW(14),
                  ),
                ),
                Padding(
                  padding: DimensionManager.onlyleft(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Congratulations!",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: ColorManager.color365314),
                      ),
                      Text(
                        "You recieved the welcome badge",
                        style: StyleManager.textWeight400Size14Color(
                            ColorManager.color4D7C0F),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget bodyUI() {
    return Padding(
      padding: DimensionManager.fromLTRB(20, 0, 20),
      child: Column(
        children: [
          Container(
              margin: DimensionManager.topAndBottom(15, 16),
              child: Text(
                "11 Feb 2020",
                style: TextStyle(
                    color: ColorManager.colorA1A1AA,
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              )),
          listData("assets/icons/award.png", "Congratulations!",
              "You recieved the welcome badge"),
          listData(
              "assets/icons/alert-circle.png",
              "You didn’t completed the activity.",
              "Named view of sunset by Emma."),
          listData(
              "assets/icons/checkmarkgreen.png",
              "You completed an activity",
              "Named Hiking on mountain by Chandler."),
        ],
      ),
    );
  }

  Widget listData(String imageName, String title, String discription) {
    return Container(
      margin: DimensionManager.onlybottom(8),
      alignment: Alignment.center,
      padding: DimensionManager.all(16),
      decoration: BoxDecoration(
        color: ColorManager.f7FEE7,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: DimensionManager.divH(48),
            width: DimensionManager.divW(48),
            decoration: BoxDecoration(
              color: ColorManager.containerBackground12,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(15.0),
            ),
            alignment: Alignment.center,
            child: Image.asset(
              imageName,
              height: 20,
              width: 14,
            ),
          ),
          Padding(
            padding: DimensionManager.onlyleft(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: ColorManager.color365314),
                ),
                Text(
                  discription,
                  style: StyleManager.textWeight400Size14Color(
                      ColorManager.color4D7C0F),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
