import 'dart:core';

import 'package:flutter/material.dart';
import 'package:task2/Utilities/dimension_manager.dart';

class SmoothPageDetails extends StatelessWidget {
  var width, height,image,title,dis;
  SmoothPageDetails(this.height,this.width,this.image,this.title,this.dis);

  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              margin:DimensionManager.fromLTRB(64,126,64),
              child: Image.asset(image.toString(),height: DimensionManager.divH(228),fit: BoxFit.cover,),
            ),
            Padding(
              padding: DimensionManager.fromLTRB(20,40,20),
              child: Text(title,
                  style:  TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 32,
                  )),
            ),
            Padding(
              padding: DimensionManager.fromLTRB(20,8,20),
              child: Text(dis,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    fontStyle: FontStyle.normal,
                    color: Color(0xff3F3F46)
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ));
  }
}
