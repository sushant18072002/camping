import 'package:flutter/material.dart';
import 'package:task2/CustumWidget/appbarutilies.dart';
import 'package:task2/Utilities/style_manager.dart';

class RecentTrips extends StatelessWidget {
  const RecentTrips({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarUtilies.appbarUtil("Recent Trips"),
      body:bodyUi(),
    );
  }
  static Widget bodyUi(){
    return Center(
      child: Column(
        children: [
          SizedBox(height: 190,),
          Image.asset("assets/images/add_trip.png",width: 230,height: 180,),
          Text("You don’t have any trips before.",style: StyleManager.textWeight400Size16black(),)
        ],
      ),
    );
  }
}
