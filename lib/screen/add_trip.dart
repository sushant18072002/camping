import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:task2/CustumWidget/appbarutilies.dart';
import 'package:task2/CustumWidget/button_ui.dart';
import 'package:task2/Utilities/color_manager.dart';
import 'package:task2/Utilities/dimension_manager.dart';
import 'package:task2/Utilities/style_manager.dart';
import 'package:task2/screen/add_trip_form.dart';
import 'package:task2/screen/mainmenu.dart';
import 'package:task2/screen/notification.dart';

import '../Model/trip_model.dart';

class AddTrip extends KFDrawerContent {
  @override
  _AddTripState createState() => _AddTripState();
}

class _AddTripState extends State<AddTrip> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorManager.white,
        appBar: AppBarUtilies.AppbarWithGridAndRigthIconBellIcon(
            "Camping Trips", widget.onMenuPressed),
        body:  bodyUi(context));
  }

  static Widget bodyUi(context) {
    var top= DimensionManager.onlytop(83);
    var hieght=DimensionManager.height;
    return Stack(
      children: [
        Column(
          children: <Widget>[
            Container(
              margin: DimensionManager.fromLTRB(20, 32, 20),
              padding: DimensionManager.fromLTRB(24, 16, 24, 16),
              decoration: BoxDecoration(
                  color: ColorManager.f7FEE7,
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "your ID",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: ColorManager.textColor4),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: DimensionManager.onlytop(4),
                        child: Text(
                          "CMP21992822",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: ColorManager.color365314),
                        ),
                      ),
                      Spacer(),
                      Image.asset(
                        "assets/icons/copy.png",
                        height: 18,
                        width:18,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(child: readDataFireStore()),
          ],
        ),
        Container(
            alignment: Alignment.bottomCenter,
            padding: DimensionManager.fromLTRB(40, 0, 40, 19),
            height: DimensionManager.height,
            child: ButtonUi.filledbutton(AddTripForm(), "Start New Trip")),
      ],
    );
  }
  /**/

  static Widget readDataFireStore(){
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return FutureBuilder<QuerySnapshot>(
      future: users
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("trips")
          .get(),
      builder: (
          BuildContext context,
          AsyncSnapshot<QuerySnapshot> snapshot,
          ) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }
        if (snapshot.hasData && snapshot.data?.size == 0) {
          return emptyTrips();
        }
        if (snapshot.connectionState == ConnectionState.done)  {
          // return Text(snapshot.data!.docs.first.data().toString());
          List<TripModel> tripModel=[];
          snapshot.data!.docs.forEach((element) {
            tripModel.add(TripModel.fromJson(element.data()));
          });
          return listTeammmatesShow(tripModel);
        }
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: DimensionManager.height,
          child: Shimmer.fromColors(
            child: Card(
              color: Colors.grey,
            ),
            baseColor: Colors.white70,
            highlightColor:ColorManager.colorA1A1AA,
            direction: ShimmerDirection.ltr,
          ),
        );
      },
    );
  }
  static Widget listTeammmatesShow(List<TripModel> tripmodel){
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: ListView.builder(
        itemCount: tripmodel.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => MainMenu(),));
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0,left: 20.0,right: 20.0),
              child: detail(tripmodel[index]),
            ),
          );
        },),
    );
  }
  static Widget detail(TripModel tripmodel){
    return Container(
      width: DimensionManager.width - 40,
      padding: DimensionManager.all(24),
      decoration: BoxDecoration(
          color: ColorManager.colorFAFAFA,
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                tripmodel.tripName.toString(),
                style: StyleManager.textweight600size20black(),
              ),
              const Spacer(),
              /*
              )*/
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0,bottom:4.0),
            child: Text(
              tripmodel.location.toString(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: StyleManager.textWeight400Size16Color(
                  ColorManager.color3F3F46),
            ),
          ),
          Container(
            child: Text(
              "Date ${tripmodel.pickDate}",
              style: StyleManager.textWeight500Size14Color(
                  ColorManager.colorA1A1AA),),
          )
        ],
      ),
    );
  }
  static Widget emptyTrips(){
    return Center(
      child: Column(
        children: [
          SizedBox(height: 190,),
          Padding(
            padding: DimensionManager.onlytop(83),
            //alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/add_trip.png",
                  height:180,
                  width: 230,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: DimensionManager.onlytop(24),
                  child: Text(
                    "You didn’t add any trips before.",
                    style: StyleManager.textWeight400Size16black(),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

}
