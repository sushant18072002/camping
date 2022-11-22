
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task2/CustumWidget/appbarutilies.dart';
import 'package:task2/FirebaseCollectionController/firestore_read_write.dart';
import 'package:task2/Model/ActivityModel.dart';
import 'package:task2/Utilities/color_manager.dart';
import 'package:task2/Utilities/color_print_logs.dart';
import 'package:task2/Utilities/dimension_manager.dart';
import 'package:task2/Utilities/style_manager.dart';
import 'package:task2/screen/mainmenu.dart';

import '../main.dart';

class AddActivities extends StatefulWidget {
  const AddActivities({Key? key}) : super(key: key);
  @override
  State<AddActivities> createState() => _AddActivitiesState();

}

class _AddActivitiesState extends State<AddActivities> {
  TextEditingController headingController=TextEditingController();
  TextEditingController descriptionController=TextEditingController();
  bool flag=false;


  @override
  void dispose() {
    super.dispose();
    headingController.dispose();
    descriptionController.dispose();
  }

  String checkIcon="assets/icons/checkmarkLigth.png";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: cusTumAppbar(),
      backgroundColor: ColorManager.white,
      body: bodyUi(),
    );
  }
  AppBar cusTumAppbar(){
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        "Add Activity",
        style: StyleManager.textweight600size20black(),
      ),
      leading: GestureDetector(
        onTap: (){
          Navigator.pop(MyApp.navigatorKey.currentContext!);
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 8, 0),
          child: Image.asset(
            "assets/icons/chevronleft.png",
            height: 24,
            width: 24,
          ),
        ),
      ),
      centerTitle: true,
      leadingWidth: 60,
      backgroundColor: ColorManager.white,
      elevation: 0,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: IconButton(
            onPressed: (){
              logSuccess("Click add activity");
              validationActivities();
            },
            icon: Image.asset(
              checkIcon,
              height: 32,
              width: 32,
            ),
          ),
        )
      ],
    );
  }
  changarAppbarIcon(){
    logInfo("change");
    setState(() {
      checkIcon ="assets/icons/checkmarkdark.png";
    });
  }
   Widget bodyUi() {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: DimensionManager.divW(20)),
          child: Column(
            children: [
              Container(
                height: DimensionManager.divH(48.0),
                margin: DimensionManager.fromLTRB(0,20,0,16),
                child: CustumTextField("Add Heading",TextInputType.text,true,headingController)
              ),
              Expanded(
                child: CustumTextField("Add Description",TextInputType.multiline,false,descriptionController)
              )
            ],
          ),
        ),
        Visibility(
          visible: flag,
          child: Container(
            height: DimensionManager.height,
            width: DimensionManager.width,
            alignment: Alignment.center,
            color: ColorManager.colorcccccc,
            child: const SizedBox(
                height: 100,
                width: 100,
                child: CircularProgressIndicator()),
          ),
        )
      ],
    );
  }
  CustumTextField(String hintText,keyBoardType,bool selectStyle,controller){
    return TextFormField(
      controller: controller,
      style:selectStyle?StyleManager.textweight600size24black():StyleManager.textWeight400Size16Color(ColorManager.color3F3F46),
      onChanged:(value) {
        if(value.isNotEmpty){
          changarAppbarIcon();
        }
        else{
          setState(() {
            checkIcon="assets/icons/checkmarkLigth.png";
          });
        }
      },
      keyboardType:keyBoardType,
      maxLines: null,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: EdgeInsets.fromLTRB(16.0, 12.0, 0.0, 12.0),
        hintStyle:selectStyle? StyleManager.textWeight600Size24color(ColorManager.colorD4D4D8):StyleManager.textWeight400Size16Color(ColorManager.colorD4D4D8),
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  void validationActivities() async{
    if(headingController.text==null||descriptionController.text==null||headingController.text==""||descriptionController.text=="")
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please fill all feild")));
    else{
      setState(() {
        flag=true;
      });
      ActivityModel activityModel=ActivityModel(heading: headingController.text,description: descriptionController.text);
      await FireStoreReadWrite().activitiesWrite(activityModel);
      setState(() {
        flag=false;
      });
    }
  }


}