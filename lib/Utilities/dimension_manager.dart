import 'package:flutter/material.dart';
import 'package:task2/main.dart';

class DimensionManager{
  static double width = 0.0;
  static double height = 0.0;


  static initialize(){
     BuildContext context=MyApp.navigatorKey.currentContext!;
     width = MediaQuery.of(context).size.width;
     height = MediaQuery.of(context).size.height;
   }
   static double  divW(double value) {
     initialize();
    return (value / 375)*width;
  }

  static double divH(double value) {
    initialize();
    return (value / 812)*height;
  }

  static fromLTRB([double left=0.0,double top=0.0,double right=0.0,double bottom=0.0]){
    return EdgeInsets.fromLTRB(divW(left),divH(top), divW(right),divH(bottom));
  }
  static all([double all=0.0]){
    return EdgeInsets.fromLTRB(divW(all),divH(all), divW(all),divH(all));
  }

  static onlyleft([double value=0.0]){
    return  EdgeInsets.only(left: DimensionManager.divW(value));
  }
  static onlytop([double value=0.0]){
    return  EdgeInsets.only(top: DimensionManager.divW(value));
  }
  static onlyright([double value=0.0]){
    return  EdgeInsets.only(right: DimensionManager.divW(value));
  }
  static onlybottom([double value=0.0]){
    return  EdgeInsets.only(bottom: DimensionManager.divW(value));
  }
  static topAndBottom([double top=0.0,double bottom=0.0]){
    return  EdgeInsets.only(top: top,bottom: DimensionManager.divW(bottom));
  }
  static symmetricWidthTop([double width=0.0,double top=0]){
    return EdgeInsets.fromLTRB(divW(width),divH(top), divW(width),divH(0));
  }
  static symmetricWidthBottom([double width=0.0,double bottom=0]){
    return EdgeInsets.fromLTRB(divW(width),0, divW(width),divH(bottom));
  }
}