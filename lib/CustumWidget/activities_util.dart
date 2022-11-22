import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shimmer/shimmer.dart';
import 'package:task2/CustumWidget/button_ui.dart';
import 'package:task2/FirebaseCollectionController/firestore_read_write.dart';
import 'package:task2/FirebaseCollectionController/storage_service.dart';
import 'package:task2/Model/ActivityModel.dart';
import 'package:task2/Model/UserModel.dart';
import 'package:task2/Utilities/color_manager.dart';
import 'package:task2/Utilities/color_print_logs.dart';
import 'package:task2/Utilities/dimension_manager.dart';
import 'package:task2/Utilities/style_manager.dart';
import 'package:task2/screen/activity_view.dart';
import 'package:task2/screen/add_activities.dart';

import '../main.dart';

class ActivitiesUtil {
  static bool flag = false;
  static BuildContext context=MyApp.navigatorKey.currentContext!;

  static Widget bodyUi() {
    CollectionReference users = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("activities");
    return StreamBuilder<QuerySnapshot>(
      stream: users.snapshots(includeMetadataChanges: true),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && snapshot.data?.size == 0) {
          logWarning("Empty list");
          return emptyActivites();
        }

        if (snapshot.data?.size != null) {
          logSuccess("List print```");
          return showActivityList(snapshot);
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

  static Widget emptyActivites() {
    return Container(
      height: DimensionManager.height,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20, 44, 20, 0),
            child: Row(
              children: [
                Text(
                  "Day 01",
                  style: StyleManager.textWeight600Size32Color(
                      ColorManager.color365314),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Image.asset(
                    "assets/icons/sun.png",
                    height: 24,
                    width: 24,
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Text(
                    "16 day’s remain",
                    style: StyleManager.textWeight400Size14Color(
                        ColorManager.colorA1A1AA),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: DimensionManager.onlytop(100),
            child: Image.asset(
              "assets/images/activities1.png",
              width: 180,
              height: 180,
            ),
          ),
          Padding(
            padding: DimensionManager.fromLTRB(0, 24, 0, 16),
            child: Text(
              "You didn’t add any Activity or Task yet.",
              style: StyleManager.textWeight400Size16Color(
                  ColorManager.color3F3F46),
            ),
          ),
          Padding(
            padding: DimensionManager.fromLTRB(130, 0, 130),
            child: ButtonUi.outlineButtonCustum(
                AddActivities(), "Add Activity", 45),
          ),
        ],
      ),
    );
  }

  static Widget showActivityList(AsyncSnapshot snapshot) {
    return Padding(
      padding: DimensionManager.fromLTRB(20, 44, 20,2),
      child: Column(
        children: [
          Padding(
            padding: DimensionManager.onlybottom(22),
            child: Row(
              children: [
                Text(
                  "Day 01",
                  style: StyleManager.textWeight600Size32Color(
                      ColorManager.color365314),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Text(
                    "16 day’s remain",
                    style: StyleManager.textWeight400Size14Color(
                        ColorManager.colorA1A1AA),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: snapshot.data.docs.length,
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                logWarning(snapshot.data.docs[index].id.toString());
                ActivityModel activityModel =
                    ActivityModel.fromJson(snapshot.data.docs[index].data());
                activityModel.idSet = snapshot.data.docs[index].id.toString();
                if(activityModel.isComplete==false){
                return Container(
                  width: DimensionManager.width,
                  height: DimensionManager.divH(124),
                  margin: DimensionManager.onlytop(20),
                  child: slider(activityModel),
                );
                }
                return Container();
              },
            ),
          )
        ],
      ),
    );
  }

  static Widget activitiesShow(ActivityModel activityModel) {
    return GestureDetector(
      onTap: (){
        logSuccess("click");
        Navigator.push(context, MaterialPageRoute(builder: (context) => ActivityView(activityModel),));
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
                  activityModel.heading.toString(),
                  style: StyleManager.textweight600size20black(),
                  maxLines: 1,
                ),
                const Spacer(),
                Text(
                  "By ${activityModel.author}",
                  style: StyleManager.textWeight500Size14Color(
                      ColorManager.colorA1A1AA),
                  maxLines: 1,
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                activityModel.description.toString(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: StyleManager.textWeight400Size16Color(
                    ColorManager.color3F3F46),
              ),
            )
          ],
        ),
      ),
    );
  }

  static Widget slider(ActivityModel activityModel) {
    logError(activityModel.id.toString());
    return Slidable(
      key: const ValueKey(0),
      startActionPane: ActionPane(
        extentRatio: 0.4,
        motion: const ScrollMotion(),
        children: [
          GestureDetector(
            onTap: (){
              update(activityModel.id.toString());
            },
            child: Container(
              width: 127,
              height: 124,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: ColorManager.color64BC26),
              child: Text(
                "Complete",
                style: StyleManager.textweight600size20white(),
              ),
            ),
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          GestureDetector(
            onTap: () {
              delete(activityModel.id.toString());
            },
            child: Container(
              width: 98,
              height: 124,
              margin: DimensionManager.onlyleft(16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: ColorManager.colorEA1601),
              child: Text(
                "Delete",
                style: StyleManager.textweight600size20white(),
              ),
            ),
          ),
        ],
      ),
      enabled: true,
      child: activitiesShow(activityModel),
    );
  }

  static delete(String id) {
     FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("activities")
        .doc(id)
        .delete().then((value) {
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Successfully Deleted")));
     });
  }
  static update(String id) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("activities")
        .doc(id)
        .delete().then((value) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Successfully Completed")));
    });
    /*FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("activities")
        .doc(id)
        .update({"isComplete":true});*/
  }
}
