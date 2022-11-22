import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:task2/CustumWidget/textfield_ui.dart';
import 'package:task2/Model/LocationModel.dart';

import 'package:task2/Utilities/color_manager.dart';
import 'package:task2/Utilities/dimension_manager.dart';
import 'package:task2/Utilities/style_manager.dart';
import 'package:task2/main.dart';
import 'package:task2/screen/location_view.dart';

class LocationSearch extends StatefulWidget {
  List<LocationModel> locatoinlist;
  LocationSearch({required this.locatoinlist});
  @override
  State<LocationSearch> createState() => _LocationSearchState();
}

class _LocationSearchState extends State<LocationSearch> {
  List<LocationModel> _displayList =[];

  @override
  void initState() {
    super.initState();
    _displayList=widget.locatoinlist;
  } // widget.locatoinlist;

  void updateList(String value) {
    setState(() {
      _displayList = widget.locatoinlist
          .where((element) =>
              element.title!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: ColorManager.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Container(
            margin: DimensionManager.fromLTRB(20, 41, 20, 48),
            child: Container(
                width: DimensionManager.divW(263),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: TextFormField(
                    onChanged: (value) => updateList(value),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    decoration: InputDecoration(
                        filled: true,
                        hintText: "Search",
                        contentPadding:
                            EdgeInsets.fromLTRB(16.0, 12.0, 0.0, 12.0),
                        hintStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: ColorManager.colorA1A1AA,
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: ColorManager.green84CC16,
                              width: 1.5,
                            ))),
                  ),
                )),
          ),
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 8, 0),
            child: GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Image.asset(
                "assets/icons/chevronleft.png",
                height: 32,
                width: 32,
              ),
            ),
          ),
          actions: [
             Container(
                  margin: DimensionManager.onlyright(25),
                  padding:EdgeInsets.all(15.0),
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
          leadingWidth: 60,
          titleSpacing: 0,
          backgroundColor: ColorManager.white,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 12),
          child: ListView.builder(
              itemCount: _displayList.length,
              itemBuilder: (context, index) => Container(
                    padding: EdgeInsets.only(
                        left: 20, bottom: 20, right: 20, top: 20),
                    child: GestureDetector(
                      onTap:  () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => LocationView(_displayList[index])));
                      },
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                              child: imageProvider(_displayList[index].image!)),
                          Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _displayList[index].title!,
                                  style: StyleManager.textweight600size20black(),
                                ),
                                Text(_displayList[index].location!,style: StyleManager.textWeight400Size12black(),)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )),
        ));
  }
  Image imageProvider(String imageUrl){
    return Image.network(imageUrl,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return SizedBox(
          height:DimensionManager.divH(70),
          width: DimensionManager.divW(100),
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
      height:DimensionManager.divH(70),
      width: DimensionManager.divW(100),
    );
  }
}
