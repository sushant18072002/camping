import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:task2/CustumWidget/counter.dart';
import 'package:task2/FirebaseCollectionController/firestore_read_write.dart';
import 'package:task2/Model/BagItemModel.dart';
import 'package:task2/Model/backpack_bag_model.dart';
import 'package:task2/Utilities/color_manager.dart';
import 'package:task2/Utilities/color_print_logs.dart';
import 'package:task2/Utilities/dimension_manager.dart';
import 'package:task2/Utilities/style_manager.dart';

class BackPackUi {
  static List<BagItemModel> bagItemModel=[];
  static Widget bagPackUi(List<BagItemModel> backpackList) {
    logSuccess(backpackList[0].toJson().toString());
    List<BackPackModel> backPackModel=BackPackModel.getItems();
    return Padding(
      padding: DimensionManager.fromLTRB(20, 18, 20),
      child: ListView.builder(
        itemCount: backpackList.length,
        itemBuilder: (context, index) {
          //backPackModel[index].title
          var imageIndex=backPackModel.indexWhere((element) {
            logWarning("${element.title.toString()}    ## ${backpackList[index].item.toString()}");
            return element.title.toString()==backpackList[index].item.toString();});
          return Padding(
            padding: DimensionManager.onlybottom(24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                    child: Image.asset(imageIndex>-1?backPackModel[imageIndex].image:"assets/images/onboarding4.png",height: 64,width: 64,)),
                Container(
                  width: DimensionManager.divW(190),
                  padding: DimensionManager.onlyleft(12),
                  child: Text(
                    backpackList[index].item.toString(),
                    style: StyleManager.textweight600size20black(),
                  ),
                ),
                Spacer(),
                Counter(),
              ],
            ),
          );
        },
      ),
    );
  }

   static Widget bodyUi() {
    return FutureBuilder<String>(
      future: FireStoreReadWrite().readTripId(),
      builder: (
          BuildContext context,
          AsyncSnapshot<String> snapshot,
          ) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const Text('Error');
          } else if (snapshot.hasData) {
            return readDataFireStore( snapshot.data!);
          } else {
            return const Text('Empty data');
          }
        } else {
          return Text('State: ${snapshot.connectionState}');
        }
      },
    );
  }
  static Widget readDataFireStore(String tripId){
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return FutureBuilder<QuerySnapshot>(
      future: users
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("trips")
          .doc(tripId)
          .collection("bagItems")
          .get(),
      builder: (
          BuildContext context,
          AsyncSnapshot<QuerySnapshot> snapshot,
          ) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }
        if (snapshot.hasData && snapshot.data?.size == 0) {
          return Text("Document does not exist");
        }
        if (snapshot.connectionState == ConnectionState.done)  {
         // return Text(snapshot.data!.docs.first.data().toString());

          snapshot.data!.docs.forEach((element) {
            bagItemModel.add(BagItemModel.fromJson(element.data()));
          });
          return bagPackUi(bagItemModel);
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
}
