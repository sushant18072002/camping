import 'package:flutter/material.dart';
import 'package:task2/CustumWidget/appbarutilies.dart';
import 'package:task2/Model/ActivityModel.dart';
import 'package:task2/Utilities/color_manager.dart';
import 'package:task2/Utilities/dimension_manager.dart';
import 'package:task2/Utilities/style_manager.dart';

class ActivityView extends StatelessWidget {
  ActivityModel activityModel;
  ActivityView(this.activityModel);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBarUtilies.appbarUtilWithRightText("Activity details", "By ${activityModel.author.toString()}"),
      body: Column(
        children: [
          Container(
            width: DimensionManager.width,
            margin:const EdgeInsets.all(20),
            padding:const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: ColorManager.colorFAFAFA,
              borderRadius: BorderRadius.circular(15)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(activityModel.heading.toString(),style: StyleManager.textweight600size24black(),),
                SizedBox(height: 16,),
                Text(activityModel.description.toString(),style: StyleManager.textWeight400Size16Color(ColorManager.color3F3F46),)
              ],
            ),
          ),
        ],
      ),


    );
  }
}
