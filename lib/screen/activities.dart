import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:task2/CustumWidget/activities_util.dart';
import 'package:task2/CustumWidget/appbarutilies.dart';
import 'package:task2/CustumWidget/backpack_ui.dart';
import 'package:task2/CustumWidget/fitness_ui.dart';
import 'package:task2/CustumWidget/teammates.dart';
import 'package:task2/CustumWidget/tripshow.dart';
import 'package:task2/Model/navigatorItem_Model.dart';
import 'package:task2/Utilities/color_manager.dart';
import 'package:task2/Utilities/dimension_manager.dart';
import 'package:task2/Utilities/image_manager.dart';
import 'package:task2/screen/add_activities.dart';
import 'package:task2/screen/add_trip_form.dart';

class ActivitiesScreen extends KFDrawerContent {

  @override
  State<ActivitiesScreen> createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> pageList = [
      ActivitiesUtil.bodyUi(),
      Fitness.bodyUi(),
      TripShow.bodyUi(),
      Teammates.bodyUi(),
    ];
    List<AppBar> appBarList = [
      AppBarUtilies.AppbarWithGridAndRigthIcon("Activities", ImageManager.plus, widget.onMenuPressed,navigatorNextPage),
      AppBarUtilies.AppbarWithGridAndRigthIcon("Fitness", ImageManager.sync, widget.onMenuPressed,refreshPage),
      AppBarUtilies.AppbarWithGridAndRigthIcon("Trips", ImageManager.plus, widget.onMenuPressed,navigatorAddTripPage),
      AppBarUtilies.AppbarWithGrid("Teammates", widget.onMenuPressed),
    ];
    return Scaffold(
        backgroundColor: ColorManager.white,
        appBar: appBarList[selectedIndex],
        body:pageList[selectedIndex],
        bottomNavigationBar: buttomNavigationBarUi());
  }
  Widget _builtItem(NavigatorItemModel item, bool isSelected) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 270),
      width: isSelected ? 140 : 40,
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Container(
            height: 40,
            padding: isSelected
                ? EdgeInsets.fromLTRB(12, 8, 12, 8)
                : EdgeInsets.all(0),
            decoration: isSelected
                ? BoxDecoration(
                color: ColorManager.drawer65A30D,
                borderRadius: BorderRadius.circular(15))
                : BoxDecoration(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                item.icon,
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: isSelected ? item.title : Container(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buttomNavigationBarUi() {
    List<NavigatorItemModel> items = NavigatorItemModel.getItems();
    return Container(
      height: DimensionManager.divH(75),
      color: ColorManager.green84CC16,
      width: DimensionManager.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: items.map((item) {
          var currentIndex = items.indexOf(item);
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = currentIndex;
              });
            },
            child: _builtItem(item, selectedIndex == currentIndex),
          );
        }).toList(),
      ),
    );
  }
  navigatorNextPage(){
    Navigator.push(context,MaterialPageRoute(builder: (context) => AddActivities(),));
  }
  refreshPage(){
    setState(() {

    });
  }
  navigatorAddTripPage(){
    Navigator.push(context,MaterialPageRoute(builder: (context) => AddTripForm(),));
  }
}
