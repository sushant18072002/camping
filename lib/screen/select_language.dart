import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:task2/CustumWidget/appbarutilies.dart';
import 'package:task2/CustumWidget/custum_check_box.dart';
import 'package:task2/Model/instructions_model.dart';
import 'package:task2/Model/language_model.dart';
import 'package:task2/Utilities/color_manager.dart';
import 'package:task2/Utilities/dimension_manager.dart';
import 'package:task2/Utilities/style_manager.dart';

class SelectLangauge extends KFDrawerContent {
  _SelectLangauge createState() => _SelectLangauge();
}
class _SelectLangauge extends State<SelectLangauge> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar:AppBarUtilies.AppbarWithGrid("Language",widget.onMenuPressed),
      body: bodyUi(),
    ) ;
  }
  Widget bodyUi(){

    List<Langauge_Model> _language=Langauge_Model.getUsers();
    return ListView.builder(
      itemCount: _language.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: DimensionManager.fromLTRB(20,10,20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(_language[index].langauge,style: StyleManager.textWeight400Size16black(),),
              Spacer(),
              CustumCheckbox()
            ],
          ),
        );
      },);
  }
}
