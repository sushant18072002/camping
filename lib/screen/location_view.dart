import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:shimmer/shimmer.dart';
import 'package:task2/CustumWidget/button_ui.dart';
import 'package:task2/Model/LocationModel.dart';
import 'package:task2/Utilities/color_manager.dart';
import 'package:task2/Utilities/color_print_logs.dart';
import 'package:task2/Utilities/dimension_manager.dart';
import 'package:task2/Utilities/style_manager.dart';
import 'package:task2/main.dart';
import 'package:task2/screen/add_trip_form.dart';

class LocationView extends StatelessWidget {
  final LocationModel _locations;

  LocationView(this._locations);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          imageProvider(_locations.image.toString()),
          Padding(
            padding: EdgeInsets.only(left: 20, top: 30),
            child: GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Image.asset(
                "assets/icons/arrow-ios-left.png",
                height: 32,
                width: 32,
              ),
            ),
          ),
          Padding(
            padding: DimensionManager.fromLTRB(20, 0, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  _locations.title.toString(),
                  style: StyleManager.textweight600size32white(),
                ),
                Padding(
                  padding: DimensionManager.onlybottom(8),
                  child: Text(
                    _locations.location.toString(),
                    style: StyleManager.textWeight500Size16White(),
                  ),
                ),
                Text(
                  _locations.discription.toString(),
                  style: StyleManager.textWeight400Size16White(),
                  textAlign: TextAlign.justify,
                ),
                Padding(
                  padding: DimensionManager.fromLTRB(20, 24, 20, 18),
                  child: ButtonUi.filledbuttonCustumWithFunction(
                      locationAddInModel, "Select Location"),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Image imageProvider(String imageUrl) {
    return Image.network(
      imageUrl,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return SizedBox(
          height: DimensionManager.height,
          width: DimensionManager.width,
          child: Shimmer.fromColors(
            child: Card(
              color: Colors.grey,
            ),
            baseColor: Colors.white70,
            highlightColor: ColorManager.colorA1A1AA,
            direction: ShimmerDirection.ltr,
          ),
        );
      },
      fit: BoxFit.cover,
      height: DimensionManager.height,
      width: DimensionManager.width,
    );
  }

  locationAddInModel() {
    tripModel.locationSet = _locations.title.toString();
    BuildContext context = MyApp.navigatorKey.currentContext!;
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => AddTripForm(),
        )).onError((error, stackTrace) {
      logError(error.toString());
    });
  }
}
