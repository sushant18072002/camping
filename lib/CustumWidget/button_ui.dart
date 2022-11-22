import 'package:flutter/material.dart';
import 'package:task2/main.dart';

import '../Utilities/color_manager.dart';
import '../Utilities/dimension_manager.dart';
import '../Utilities/style_manager.dart';


class ButtonUi{
 static Widget filledbutton(classname,text){
   return ElevatedButton(
     onPressed: () {
       Navigator.push(
           MyApp.navigatorKey.currentContext!,
           MaterialPageRoute(builder: (context) => classname));
     },
     style: ElevatedButton.styleFrom(
         primary:ColorManager.green84CC16,
         minimumSize: Size.fromHeight(DimensionManager.divH(44)),
         shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(10.0),
         )
       //fixedSize: Size(double.infinity, height/18.75)
     ),
     child: Text(
       text,
       style: StyleManager.textWeight500Size14black(),
     ),
   );
 }
 static Widget filledbuttonCustumWithFunction(function,text){
   return ElevatedButton(
     onPressed: () {
      function();
     },
     style: ElevatedButton.styleFrom(
         primary:ColorManager.green84CC16,
         minimumSize: Size.fromHeight(DimensionManager.divH(44)),
         shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(10.0),
         )
       //fixedSize: Size(double.infinity, height/18.75)
     ),
     child: Text(
       text,
       style: StyleManager.textWeight500Size14black(),
     ),
   );
 }
 static Widget outlineButtonCustum(classname,text,height){
   return  OutlinedButton(
     onPressed: () {
       Navigator.push(MyApp.navigatorKey.currentContext!,
           MaterialPageRoute(builder: (context) => classname));

     },
     style: OutlinedButton.styleFrom(
         primary: ColorManager.green84CC16,
         minimumSize: Size.fromHeight(DimensionManager.divH(height.toDouble())),
         side: BorderSide(
           color: ColorManager.green84CC16,
           width: 1.5,
         ),
         shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(10.0),
         )
       //fixedSize: Size(double.infinity, height/18.75)
     ),
     child: Text(
       text,
       style: TextStyle(
           fontFamily: 'SF Pro Text',
           fontWeight: FontWeight.w500,
           fontSize: 14,
           color: ColorManager.green84CC16),
     ),
   );
 }
 static Widget outlineButtonWithFunction(function,text,height){
   return  OutlinedButton(
     onPressed: () {
       function();
     },
     style: OutlinedButton.styleFrom(
         primary: ColorManager.green84CC16,
         minimumSize: Size.fromHeight(DimensionManager.divH(height.toDouble())),
         side: BorderSide(
           color: ColorManager.green84CC16,
           width: 1.5,
         ),
         shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(10.0),
         )
       //fixedSize: Size(double.infinity, height/18.75)
     ),
     child: Text(
       text,
       style: TextStyle(
           fontFamily: 'SF Pro Text',
           fontWeight: FontWeight.w500,
           fontSize: 14,
           color: ColorManager.green84CC16),
     ),
   );
 }

}
