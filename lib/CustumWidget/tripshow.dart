import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:task2/Model/trip_model.dart';
import 'package:task2/Utilities/color_manager.dart';
import 'package:task2/main.dart';
import 'package:task2/screen/TripView.dart';

import '../Utilities/dimension_manager.dart';
import '../Utilities/style_manager.dart';

class TripShow{

  static Widget bodyUi(){
    return readDataFireStore();
  }

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
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: tripmodel.length,
      itemBuilder: (context, index) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 10.0,left: 20.0,right: 20.0),
        child: detail(tripmodel[index]),
      );
    },);
  }
  static Widget detail(TripModel tripmodel){
    return GestureDetector(
      onTap: (){
        BuildContext context=MyApp.navigatorKey.currentContext!;
        Navigator.push(context, MaterialPageRoute(builder: (context) => TripView(tripmodel),));
      },
      child: Container(
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
      ),
    );
  }
  static Widget emptyTrips(){
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