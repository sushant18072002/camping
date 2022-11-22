import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:task2/CustumWidget/appbarutilies.dart';
import 'package:task2/CustumWidget/button_ui.dart';
import 'package:task2/CustumWidget/textfield_ui.dart';
import 'package:task2/FirebaseCollectionController/firestore_read_write.dart';
import 'package:task2/Model/LocationModel.dart';
import 'package:task2/Utilities/color_manager.dart';
import 'package:task2/Utilities/color_print_logs.dart';
import 'package:task2/Utilities/dimension_manager.dart';
import 'package:task2/Utilities/string_manager.dart';
import 'package:task2/screen/location_search.dart';


class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationState();
}

class _LocationState extends State<LocationScreen> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: ColorManager.white,
      resizeToAvoidBottomInset : false,
      appBar: AppBarUtilies.appbarUtil("Locations"),
      body: fetchData(),
    );
  }
  Widget fetchData() {
    CollectionReference reference = FirebaseFirestore.instance
        .collection("admin")
        .doc("4w1CUwPhki04mINaTotJ")
        .collection("Locations");
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
          List<LocationModel> locatoinlist = [];
          snapshot.data!.docs.forEach((element) {
            locatoinlist.add(LocationModel.fromJson(element.data()));
          });
          logInfo(locatoinlist.length.toString());
          return bodyUi(locatoinlist);
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
  Widget bodyUi( List<LocationModel> locatoinlist){

    return Column(
      children: [
        Container(
          margin: DimensionManager.fromLTRB(20, 41, 20,48),
          child: Row(
            children: [
              Container(
                  width: DimensionManager.divW(263),
                  child: TextFieldUi.CustumTextField(context, LocationSearch(locatoinlist:locatoinlist), "Search")),
              Spacer(),
              Container(
                  width: 48,
                  height: 48,
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/icons/search.png",
                    height: 24,
                    width: 24,
                  ),
                  decoration: BoxDecoration(
                    color: ColorManager.green84CC16,
                    borderRadius: BorderRadius.circular(15),
                  )),
            ],
          ),
        ),
        Container(
          height: 550,
          child: ListView(
            children: [
              CarouselSlider(
                items: carouseItem(locatoinlist),

                //Slider Container properties
                options:CarouselOptions(
                  height: 500,
                  clipBehavior:Clip.hardEdge ,
                  enlargeStrategy:CenterPageEnlargeStrategy.height,
                  //aspectRatio: 16/9,
                  viewportFraction: 0.74,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: false,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
  List<Widget> carouseItem(List<LocationModel> locatoinlist){
    List<Widget> listWidget=[];
    logInfo(listWidget.length.toString());
    locatoinlist.forEach((element) {
      listWidget.add( Stack(
        alignment:Alignment.bottomCenter,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(14,0,14,100),
            constraints: BoxConstraints(
              minHeight: DimensionManager.divH(400), //minimum height
              minWidth: DimensionManager.divW(267),
            ),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                    child: imageProvider(element.image.toString())),
                Container(
                    alignment: Alignment.bottomCenter,
                    padding: const EdgeInsets.only(bottom:36),
                    child: Text(element.title.toString(),style: TextStyle(color: ColorManager.white,fontWeight: FontWeight.w600,fontSize: 24,shadows:  [ BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 0.4,
                      blurRadius: 12, // changes position of shadow
                    ),]),)
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(52,0.0,52,80),
            height: 44,
            width: 163,
            child: ButtonUi.filledbutton(LocationSearch(locatoinlist:locatoinlist),"Explore"),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(0,32,0,40),
            child: Text("Region",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,),),
          ),
          Text(element.region.toString(),style: TextStyle(fontWeight: FontWeight.w600,fontSize: 32),maxLines: 1,),
        ],
      )
      );
    });
    logInfo(listWidget.length.toString());
    return listWidget;

  }
  Image imageProvider(String imageUrl){
    return Image.network(imageUrl,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return SizedBox(
          height:DimensionManager.divH(400),
          width: DimensionManager.divW(267),
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
      height:DimensionManager.divH(400),
      width: DimensionManager.divW(267),
    );
  }
}



