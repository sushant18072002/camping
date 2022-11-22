import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:task2/CustumWidget/appbarutilies.dart';
import 'package:task2/FirebaseCollectionController/firestore_read_write.dart';
import 'package:task2/Model/TipsAndTricksModel.dart';
import 'package:task2/Model/tip_and_tricks_model.dart';
import 'package:task2/Model/trip_model.dart';
import 'package:task2/Utilities/color_manager.dart';
import 'package:task2/Utilities/dimension_manager.dart';
import 'package:task2/Utilities/style_manager.dart';

import '../FirebaseCollectionController/storage_service.dart';
import '../Utilities/color_print_logs.dart';

class TipsAndTricks extends KFDrawerContent {
  @override
  State<TipsAndTricks> createState() => _TipsAndTricksState();
}

class _TipsAndTricksState extends State<TipsAndTricks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar:
          AppBarUtilies.AppbarWithGrid("Tips & Tricks", widget.onMenuPressed),
      body:fetchData(),
    );
  }
  Widget fetchData() {
    CollectionReference reference = FirebaseFirestore.instance
        .collection("admin")
        .doc("4w1CUwPhki04mINaTotJ")
        .collection("TipsAndTricks");
    return FutureBuilder<QuerySnapshot>(
      future:reference.get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && snapshot.data?.size == 0) {
          logWarning("Empty list");
        }

        if (snapshot.data?.size != null) {
          logSuccess("List print```");
          List<TipsAndTricksModel> tipsAndTricksModel=[];
          snapshot.data!.docs.forEach((element) {
            tipsAndTricksModel.add(TipsAndTricksModel.fromJson(element.data()));
          });
          return bodyUi(tipsAndTricksModel);
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

  Widget bodyUi(List<TipsAndTricksModel> tipsAndTricksModel) {
    return Padding(
      padding: DimensionManager.fromLTRB(20, 15, 20),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        itemCount: tipsAndTricksModel.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: index != 0
                ? DimensionManager.onlytop(24)
                : DimensionManager.onlytop(0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(tipsAndTricksModel[index].imageUrl.toString(),
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return SizedBox(
                  width: 120,
                  height: 80,
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
              width: 120,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
                Padding(
                  padding: DimensionManager.onlyleft(16),
                  child: Column(
                    children: [
                      Container(
                          width: DimensionManager.divW(198),
                          child: Text(
                            tipsAndTricksModel[index].title.toString(),
                            style: StyleManager.textWeight500Size14black(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          )),
                      Container(
                          width: DimensionManager.divW(198),
                          child: Text(
                            tipsAndTricksModel[index].discription.toString(),
                            style: StyleManager.textWeight400Size12color(
                                ColorManager.color3F3F46),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          )),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
