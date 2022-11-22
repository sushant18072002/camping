import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:task2/CustumWidget/appbarutilies.dart';
import 'package:task2/Model/instructions_model.dart';
import 'package:task2/Utilities/color_manager.dart';
import 'package:task2/Utilities/dimension_manager.dart';
import 'package:task2/Utilities/style_manager.dart';

class HowToUse extends KFDrawerContent {
  _HowToUse createState() => _HowToUse();
}
class _HowToUse extends State<HowToUse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar:AppBarUtilies.AppbarWithGrid("How To Use",widget.onMenuPressed),
      body: bodyUi(),
    ) ;
  }
  Widget bodyUi(){

    List<Instructions_Model> _instructions=Instructions_Model.getUsers();
    return Padding(
      padding:EdgeInsets.only(top: 10.0),
      child: ListView.builder(
        itemCount: _instructions.length,
        itemBuilder: (context, index) {
        return Container(
          margin: DimensionManager.fromLTRB(20,0,20,15),
          decoration: BoxDecoration(
            color: ColorManager.f7FEE7,
            borderRadius: BorderRadius.circular(10)
          ),
          padding: DimensionManager.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                margin: DimensionManager.onlyright(8),
                decoration: BoxDecoration(
                  color: ColorManager.colorECFCCB,
                  borderRadius: BorderRadius.circular(10)
                ),
                alignment: Alignment.center,
                child: Text(_instructions[index].Id.toString(),style: StyleManager.textWeight600Size24color(ColorManager.color365314),),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_instructions[index].title,style: StyleManager.textWeight500Size14Color(ColorManager.color365314)),
                  Text(_instructions[index].details,style: StyleManager.textWeight500Size14Color(ColorManager.color4D7C0F),)
                ],
              )
            ],
          ),
        );
      },),
    );
  }
}
