import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:task2/FirebaseCollectionController/firestore_read_write.dart';
import 'package:task2/Model/TeammatesModel.dart';
import 'package:task2/Model/UserModel.dart';
import 'package:task2/Utilities/dimension_manager.dart';
import 'package:task2/Utilities/style_manager.dart';
import 'package:task2/screen/teammates_view.dart';

import '../Utilities/color_manager.dart';


import 'package:flutter/material.dart';
import 'package:task2/Model/TeammatesModel.dart';
import 'package:task2/Utilities/dimension_manager.dart';
import 'package:task2/Utilities/style_manager.dart';
import 'package:task2/screen/teammates_view.dart';

import '../Utilities/color_manager.dart';
import '../Utilities/color_print_logs.dart';

class Teammates {
  static Widget bodyUi() {
    CollectionReference users = FirebaseFirestore.instance
        .collection('users');
    return StreamBuilder<QuerySnapshot>(
      stream: users.snapshots(includeMetadataChanges: true),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && snapshot.data?.size == 0) {
          logWarning("Empty list");
          return Text("Empty list");
        }

        if (snapshot.data?.size != null) {
          logSuccess("List print```");
          List<UserModel> usermodel=[];
          snapshot.data!.docs.forEach((element) {
            usermodel.add(UserModel.fromJson(element.data()));
          });

          return showDetails(usermodel);
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
  static Widget showDetails(List<UserModel> usermodel) {
    return Container(
      padding: DimensionManager.all(20),
      child: ListView.builder(
        itemCount: usermodel.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: DimensionManager.onlybottom(30),
            child: GestureDetector(
              onTap: () {
                print("click");
                //TeammatesModel singularList=usermodel[index];
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            TeammateView(usermodel: usermodel[index])));
              },
              child: Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                        child: imageProvider(usermodel[index].image.toString())),
                    Padding(
                      padding: DimensionManager.onlyleft(
                        16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            usermodel[index].name.toString(),
                            style: StyleManager.textweight600size20black(),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Chef",
                            style: StyleManager.textWeight400Size14color(
                                ColorManager.colorA1A1AA),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  static Widget imageProvider(String imageUrl){
    if(imageUrl.length<10||imageUrl.isEmpty){
      return Image.asset("assets/images/Avatarrectangle.png", fit: BoxFit.cover,
        height: 100,
        width: 100,);
    }
    else
    return Image.network(imageUrl,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return SizedBox(
          height: 100,
          width: 100,
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
      fit: BoxFit.cover,
      height: 100,
      width: 100,
    );
  }
}

// class Teammates {
//   static Widget teammatesList(List<TeammatesModel> usermodel) {
//     return Container(
//       padding: DimensionManager.all(20),
//       child: ListView.builder(
//         itemCount: usermodel.length,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: DimensionManager.onlybottom(30),
//             child: GestureDetector(
//               onTap: () {
//                 print("click");
//                 //TeammatesModel singularList=usermodel[index];
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) =>
//                             TeammateView(usermodel: usermodel[index])));
//               },
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Image.asset(
//                     usermodel[index].image,
//                     height: 100,
//                     width: 100,
//                   ),
//                   Padding(
//                     padding: DimensionManager.onlyleft(
//                       16,
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           usermodel[index].name,
//                           style: StyleManager.textweight600size20black(),
//                         ),
//                         SizedBox(
//                           height: 8,
//                         ),
//                         Text(
//                           usermodel[index].profile,
//                           style: StyleManager.textWeight400Size14color(
//                               ColorManager.colorA1A1AA),
//                         ),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
//   static Widget bodyUi()  {
//     return FutureBuilder<String>(
//       future: FireStoreReadWrite().readTripId(),
//       builder: (
//           BuildContext context,
//           AsyncSnapshot<String> snapshot,
//           ) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return CircularProgressIndicator();
//         } else if (snapshot.connectionState == ConnectionState.done) {
//           if (snapshot.hasError) {
//             return const Text('Error');
//           } else if (snapshot.hasData) {
//             return readTeammates( snapshot.data!);
//           } else {
//             return const Text('Empty data');
//           }
//         } else {
//           return Text('State: ${snapshot.connectionState}');
//         }
//       },
//     );
//   }
//
//   static Widget readTeammates(String tripId) {
//     //List<TeammatesModel> usermodel = TeammatesModel.getActivites();
//     CollectionReference users = FirebaseFirestore.instance.collection('users');
//     return FutureBuilder<QuerySnapshot>(
//       future: users
//           .doc(FirebaseAuth.instance.currentUser!.uid)
//           .collection("trips")
//           .doc(tripId)
//           .collection("bagItems")
//           .get(),
//       builder: (BuildContext context,
//           AsyncSnapshot<QuerySnapshot> snapshot,) {
//         if (snapshot.hasError) {
//           return Text("Something went wrong");
//         }
//         if (snapshot.hasData && snapshot.data?.size == 0) {
//           return Text("Document does not exist");
//         }
//         if (snapshot.connectionState == ConnectionState.done) {
//           // return Text(snapshot.data!.docs.first.data().toString());
//           snapshot.data!.docs.forEach((element) {
//             bagItemModel.add(BagItemModel.fromJson(element.data()));
//           });
//           return bagPackUi(bagItemModel);
//         }
//         return Text("loading");
//       },
//     );
//   }
//
// }
