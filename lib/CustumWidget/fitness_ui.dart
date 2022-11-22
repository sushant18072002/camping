import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:task2/CustumWidget/appbarutilies.dart';
import 'package:task2/Utilities/dimension_manager.dart';
import 'package:task2/Utilities/style_manager.dart';

import '../Utilities/color_manager.dart';

class Fitness {
  static Widget bodyUi() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: DimensionManager.fromLTRB(20, 36, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Fitness Status",
                  style:
                      StyleManager.textWeight600Size32Color(ColorManager.black),
                ),
                Padding(
                  padding:DimensionManager.fromLTRB(16,4),
                  child: Container(
                    height: 16,
                    width: 16,
                    decoration: BoxDecoration(
                        color: ColorManager.color64BC26,
                        borderRadius: BorderRadius.circular(8)),
                  ),
                )
              ],
            ),
            Padding(
              padding: DimensionManager.topAndBottom(4, 16),
              child: Text(
                "You are very good in fitness!",
                style: StyleManager.textWeight400Size14Color(
                    ColorManager.color3F3F46),
              ),
            ),
            fitnessDetails("assets/icons/running-man.png","Running","200 steps",80),
            fitnessDetails("assets/icons/man-on-mountain.png","Hiking","3Mil",90),
            fitnessDetails("assets/icons/man-drowing.png","Swim","0%",0),
          ],
        ),
      ),
    );
  }

  static Widget fitnessDetails(
      String image, String title, String units,int percent) {
    return Container(
      width: double.infinity,
      margin:DimensionManager.onlytop(24),
      padding: DimensionManager.all(24),
      decoration: BoxDecoration(
          color: ColorManager.f7FEE7, borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                image,
                width: 24,
                height: 24,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                title,
                style: StyleManager.textweight600size20Color(
                    ColorManager.color365314),
              ),
              Spacer(),
              Text(
                units,
                style: StyleManager.textweight400size20color(
                    ColorManager.color365314),
              )
            ],
          ),
          Padding(
            padding: DimensionManager.topAndBottom(16, 8),
            child: Text(
              "$percent %",
              style: StyleManager.textWeight400Size16Color(
                  ColorManager.color4D7C0F),
            ),
          ),
          LinearPercentIndicator(
            //width: DimensionManager.divW(287),
            padding: const EdgeInsets.all(0),
            lineHeight: 14,
            percent: percent/100,
            progressColor: ColorManager.green84CC16,
            backgroundColor: ColorManager.colorD9F99D,
            barRadius: const Radius.circular(15),
          )
        ],
      ),
    );
  }
}
