import 'package:flutter/material.dart';
import 'package:task2/CustumWidget/appbarutilies.dart';
import 'package:task2/Model/trip_model.dart';
import 'package:task2/Utilities/color_manager.dart';
import 'package:task2/Utilities/color_print_logs.dart';

import '../Utilities/style_manager.dart';

class TripView extends StatelessWidget {
  TripModel tripModel;
  TripView(this.tripModel);

  _buildteammatesShow() {
    List<Widget> teammatesShow = [];
    List<String>? teammates=tripModel.teammates;
    teammates!.forEach((value) {
      teammatesShow.add(
        Text(
          "${value}",
          style: StyleManager.textWeight500Size14Color(
              ColorManager.colorA1A1AA),),
      );
    });
    return Column(
      children: teammatesShow,
    );
  }
  @override
  Widget build(BuildContext context) {
    logSuccess(tripModel.toJson().toString());

    return Scaffold(
      appBar: AppBarUtilies.appbarUtil("Trip details"),
      backgroundColor: ColorManager.white,
      body:  Container(
        margin:const EdgeInsets.all(20),
        padding:const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(tripModel.tripName.toString().toUpperCase(),style: StyleManager.textweight600size24black(),),
            SizedBox(height: 16,),
            Text("Location:",style: StyleManager.textWeight400Size16Color(ColorManager.color3F3F46),),
            Text("${tripModel.location.toString()}",style: StyleManager.textWeight500Size14Color(
                ColorManager.colorA1A1AA),),
            SizedBox(height: 8,),
            Text("Teammates:",style: StyleManager.textWeight400Size16Color(ColorManager.color3F3F46),),
            // ListView.builder(
            //   itemCount:teammates!.length,
            //   itemBuilder: (context, index) {
            //   return Container(
            //     child: Text(
            //       "${teammates[index]}",
            //       style: StyleManager.textWeight500Size14Color(
            //           ColorManager.colorA1A1AA),),
            //   );
            // },),
            _buildteammatesShow(),
            SizedBox(height: 8,),
            Text("Date:",style: StyleManager.textWeight400Size16Color(ColorManager.color3F3F46),),
            Container(
              child: Text(
                "${tripModel.pickDate}",
                style: StyleManager.textWeight500Size14Color(
                    ColorManager.colorA1A1AA),),
            )
          ],
        ),
      ),
    );
  }
}
