import 'package:flutter/material.dart';
import 'package:task2/CustumWidget/appbarutilies.dart';
import 'package:task2/CustumWidget/button_ui.dart';
import 'package:task2/Utilities/color_manager.dart';
import 'package:task2/Utilities/dimension_manager.dart';
import 'package:task2/screen/add_teammates.dart';

class NewAddTeamMates extends StatelessWidget {
  const NewAddTeamMates({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBarUtilies.appbarUtil("Add Teammates"),
      backgroundColor: ColorManager.white,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 168,),
              Image.asset("assets/images/LocationIllustration.png",height: 154,width: 230,),
              Container(
                padding: DimensionManager.fromLTRB(0,24,0,8),
                child: Text("You didn’t have any teammates added."),
              ),
              Container(
                width: 136,
                child: ButtonUi.outlineButtonCustum(AddTeammates(),"Add Teammate",45),
              )

            ],
          ),
        ],
      ),
    );
  }
}
