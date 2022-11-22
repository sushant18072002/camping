import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:task2/CustumWidget/appbarutilies.dart';
import 'package:task2/Utilities/color_manager.dart';
import 'package:task2/Utilities/dimension_manager.dart';
import 'package:task2/Utilities/style_manager.dart';

class ExitTrip extends KFDrawerContent {
  @override
  State<ExitTrip> createState() => _ExitTripState();
}

class _ExitTripState extends State<ExitTrip> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarUtilies.AppbarWithGrid("Exit Trip", widget.onMenuPressed),
        backgroundColor: ColorManager.white,
        body: bodyUi());
  }

  Widget bodyUi() {
    return Padding(
      padding: DimensionManager.fromLTRB(20, 10,20),
      child: Column(
        children: [
          Text(
            "Exiting trip will remove your teammates access from the team and you can’t be able to catch it by back. Are you still want to exit?",
            style: StyleManager.textWeight400Size16Color(
                ColorManager.color71717A),
            textAlign:TextAlign.justify,
          ),
          Padding(
            padding:DimensionManager.onlytop(20),
            child: filledButton("Exit Anyway"),
          )
        ],
      ),
    );
  }

  Widget filledButton(text) {
    return ElevatedButton(
      onPressed: () {
        SystemNavigator.pop();
      },
      style: ElevatedButton.styleFrom(
          primary: ColorManager.colorEA1601,
          minimumSize: Size.fromHeight(DimensionManager.divH(44)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          )
          //fixedSize: Size(double.infinity, height/18.75)
          ),
      child: Text(
        text,
        style: StyleManager.textWeight500Size14White(),
      ),
    );
  }
}
