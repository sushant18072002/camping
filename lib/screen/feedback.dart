import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:task2/CustumWidget/appbarutilies.dart';
import 'package:task2/CustumWidget/button_ui.dart';
import 'package:task2/CustumWidget/textfield_ui.dart';
import 'package:task2/FirebaseCollectionController/firestore_read_write.dart';
import 'package:task2/Model/FeedbackModel.dart';
import 'package:task2/Utilities/color_manager.dart';
import 'package:task2/Utilities/dimension_manager.dart';
import 'package:task2/Utilities/style_manager.dart';

import '../main.dart';

class FeedBack extends KFDrawerContent {

  @override
  State<FeedBack> createState() => _FeedBackState();

}

class _FeedBackState extends State<FeedBack> {
  bool onSubtmit=true,flag=false;
  TextEditingController nameController=TextEditingController();
  TextEditingController messageController=TextEditingController();


  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar:onSubtmit?AppBarUtilies.AppbarWithGrid("Feedback", widget.onMenuPressed):null,
      body: onSubtmit?bodyUi(context):bodyUiSubtmit(context),
    );
  }
  Widget bodyUi(context){
    return Stack(
      children: [
        Padding(
          padding: DimensionManager.fromLTRB(20,10,20),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              Text("We are continously trying to make the app better and your experience is matter. If you are seeing any kind of problems or bugs. Let us know we will listen you.",style: StyleManager.textWeight400Size16Color(ColorManager.color71717A),),
              Padding(padding: DimensionManager.fromLTRB(20,0,20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:DimensionManager.topAndBottom(24,20),
                      child: TextFieldUi.LabelTextField("Name",false,0.0,"",nameController),
                    ),
                    Text("Message",style: StyleManager.textWeight400Size16Color(ColorManager.color71717A),),
                    Container(
                      //height: DimensionManager.divH(192),
                      padding:DimensionManager.topAndBottom(12,24),
                      child:
                      CustumTextField(messageController),
                    ),
                    filledbutton("Save")
                  ],
                ),
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
  Widget CustumTextField(controller){
    return Container(
      height: DimensionManager.divH(216),
      width: DimensionManager.divW(295),
      decoration: BoxDecoration(
        color: ColorManager.colorFAFAFA,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        maxLines: null,
        controller: controller,
        style: StyleManager.textWeight400Size16Color(ColorManager.color3F3F46),
        keyboardType: TextInputType.multiline,
        textAlign: TextAlign.justify,
        decoration: InputDecoration(
          //hintText: hint,
          contentPadding: EdgeInsets.fromLTRB(16.0,12.0,16.0,12.0),
          //hintStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: ColorManager.colorA1A1AA,),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
   Widget filledbutton(text){
    return ElevatedButton(
      onPressed: () {
        functionWriteFeedback();
      },
      child: Text(
        text,
        style: StyleManager.textWeight500Size14black(),
      ),
      style: ElevatedButton.styleFrom(
          primary:ColorManager.green84CC16,
          minimumSize: Size.fromHeight(DimensionManager.divH(44)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          )
        //fixedSize: Size(double.infinity, height/18.75)
      ),
    );
  }
   Widget bodyUiSubtmit(context){
    return  Container(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: DimensionManager.divH(180),
            margin:DimensionManager.onlybottom(24),
            child: Image.asset("assets/images/hurrey.png"),
          ),
          Text(
            "Hurrey",
            style: StyleManager.textweight600size24black(),
          ),
          Padding(
            padding: DimensionManager.fromLTRB(0,8,0,24),
            child: Text(
              "Thank you for submitting your valuable\n review. We will read your message soon.",
              style:StyleManager.textWeight400Size16color(ColorManager.color3F3F46)),
            ),
          Padding(
            padding: DimensionManager.fromLTRB(40,0,40),
            //EdgeInsets.fromLTRB(divW(40), divH(0), divH(40), 0),
            child: ButtonUi.filledbuttonCustumWithFunction( changeStateFalse, "Go back")
          ),
        ],
      ),
    );
  }
  functionWriteFeedback(){
    setState(() {
      flag=true;
    });
    if(nameController.text.isEmpty||messageController.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please all fields")));
    }
    else{
      FeedbackModel feedbackModel=FeedbackModel();
      feedbackModel.nameSet=nameController.text;
      feedbackModel.messageSet=messageController.text;
      FireStoreReadWrite().feedbackWrite(feedbackModel);
    }
    setState(() {
      onSubtmit=false;
      flag=false;
    });
  }
  changeStateFalse(){
    setState(() {
      onSubtmit=true;
      flag=false;
    });
  }
}
