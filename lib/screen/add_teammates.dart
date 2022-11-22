import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task2/CustumWidget/appbarutilies.dart';
import 'package:task2/CustumWidget/button_ui.dart';
import 'package:task2/CustumWidget/textfield_ui.dart';
import 'package:task2/Model/trip_model.dart';
import 'package:task2/Utilities/color_manager.dart';
import 'package:task2/Utilities/color_print_logs.dart';
import 'package:task2/Utilities/dimension_manager.dart';
import 'package:task2/Utilities/style_manager.dart';
import 'package:task2/screen/add_trip_form.dart';

class AddTeammates extends StatefulWidget {
  TripModel? tripModel;
  AddTeammates({this.tripModel});

  @override
  State<AddTeammates> createState() => _AddTeammatesState();
}

class _AddTeammatesState extends State<AddTeammates> {
  TextEditingController idController=TextEditingController();


  @override
  void initState() {
    super.initState();
    logInfo(FirebaseAuth.instance.currentUser.toString());
  }

  @override
  void dispose() {
    super.dispose();
    idController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarUtilies.appbarUtil("Add Teammates"),
      backgroundColor: ColorManager.white,
      body:conditionForUi()
    );
  }
  Widget conditionForUi(){
  if(widget.tripModel!.teammates==null){
  widget.tripModel!.teammatesSet=[];
  return emptyTeamatesBodyUi();
  }
  else
    return addTeammateBodyUi();
}
  Widget emptyTeamatesBodyUi(){
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 168,),
            Image.asset("assets/images/LocationIllustration.png",height: 154,width: 230,),
            Container(
              padding: DimensionManager.fromLTRB(0,24,0,8),
              child: Text("You didn’t have any teammates added."),
            ),
            Container(
              width: 136,
              child: ButtonUi.outlineButtonWithFunction(initializeAndReload,"Add Teammate",45),
            )

          ],
        ),
      ],
    );
  }
  Widget addTeammateBodyUi(){
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: DimensionManager.fromLTRB(20, 25, 20),
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Say your teammate to log-in first on Camping App. then your teammate will automatically recieve the ID. Then put the ID here and he will recieve the notification of invite. When he accept the request he’ll automatically add on to your team.",
            style: StyleManager.textWeight400Size16Color(
                ColorManager.color71717A),
            textAlign: TextAlign.justify,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                TextFieldUi.LabelTextField("Email", false, 24,"",idController),
                Padding(
                  padding: DimensionManager.onlytop(20),
                  child: filledbuttonCustum("Sent Request"),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget filledbuttonCustum(text){
    return ElevatedButton(
      onPressed: () {
        checkIfEmailExist(idController.text);
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
  Future<bool> checkIfEmailExist(String emailAddress) async {
    logWarning("click");
    try {
      final list = await FirebaseAuth.instance.fetchSignInMethodsForEmail(emailAddress.trim());
      if (list.isNotEmpty) {
        logSuccess("Exists...............");
        if(widget.tripModel!.teammates==null){
          widget.tripModel!.teammatesSet=[];
        }
          List<String>? teammatesList=widget.tripModel!.teammates;
          teammatesList?.add(emailAddress.trim());
          widget.tripModel!.teammatesSet=teammatesList!;
          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => AddTripForm(),));
        return true;
      } else {
        logInfo("Do not exits");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Do not exits")));
        return false;
      }
    } catch (error) {
      logError(error.toString());
      return true;
    }
  }
  initializeAndReload(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AddTeammates(tripModel: tripModel),));
  }
}
