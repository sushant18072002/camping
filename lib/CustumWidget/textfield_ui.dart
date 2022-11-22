

import 'package:flutter/material.dart';

import '../Utilities/color_manager.dart';
import '../Utilities/dimension_manager.dart';
import '../Utilities/style_manager.dart';


class TextFieldUi{
  static Widget LabelTextField([String laBel="",bool obscureText=false,double top=0.0,String initialValue="", controller]){
    return Padding(
      padding: DimensionManager.onlytop(top.toDouble()),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          TextFieldUi.LabelText(laBel),
      Padding(
      padding: DimensionManager.onlytop(8.0),
      child: TextFieldUi.TextField(obscureText,"",48.0,controller),
      ),
      ]),
    );
  }
  static Widget LabelText(String label){
    return  Text(
      label,
      style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: ColorManager.color71717A),
    );
  }
  static Widget TextField([bool obscureText=false,String hint="",double hieght=48.0,controller]){
    return Container(
      height: DimensionManager.divH(hieght),
      child: TextFormField(
        obscureText: obscureText,
        controller: controller,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: ColorManager.color3F3F46
        ),
        decoration: InputDecoration(
          filled: true,
          hintText: hint,
          contentPadding: EdgeInsets.fromLTRB(16.0,12.0,16.0,12.0),
          hintStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: ColorManager.colorA1A1AA,),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
  static Widget CustumTextField(context,classname,String hint){
    return SizedBox(
      height: DimensionManager.divH(48.0),
      child: TextFormField(
        keyboardType: TextInputType.none,
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) =>classname ));
        },
        style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: ColorManager.color3F3F46
        ),
        decoration: InputDecoration(
          filled: true,
          hintText: hint,
          fillColor: ColorManager.colorFAFAFA,
          contentPadding: EdgeInsets.fromLTRB(16.0,12.0,0.0,12.0),
          hintStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: ColorManager.colorA1A1AA,),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}