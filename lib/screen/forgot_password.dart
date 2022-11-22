import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:task2/CustumWidget/appbarutilies.dart';
import 'package:task2/Model/sign_up_model.dart';
import 'package:task2/Utilities/color_manager.dart';
import 'package:task2/Utilities/dimension_manager.dart';
import 'confirm_otp.dart';



class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController phoneController=TextEditingController();

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBarUtilies.appbarUtil("Forgot Password"),
      body: Padding(
        padding: DimensionManager.fromLTRB(20,24,20),
        //EdgeInsets.fromLTRB(divW(20), divH(24), divW(20), 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "To get your new password you need to put\n your phone number down below. and we will\n send you an OTP on that number for \nconfirmation.",
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: Color(0xff71717A)),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: DimensionManager.fromLTRB(20,40,20),
              //EdgeInsets.fromLTRB(0, divH(40), 0, 0),
              child: Text(
                "Phone",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff71717A)),
              ),
            ),
            Padding(
              padding: DimensionManager.onlytop(8),
              //EdgeInsets.fromLTRB(0, divH(8), 0, 0),
              child: Container(
                height: DimensionManager.divH(48),
                child: TextFormField(
                  controller: phoneController,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff3F3F46)
                  ),
                  inputFormatters: [
                    MaskTextInputFormatter(mask: "+91 | ###-###-####")
                  ],
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: "+91",
                    filled: true,
                    hintStyle: TextStyle(fontWeight: FontWeight.w400,fontSize: 16,color: Color(0xffD4D4D8)),
                    fillColor: Color(0xffFAFAFA),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),

            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: ElevatedButton(
                onPressed: () {
                  String phonenoCheck=phoneController.text.replaceAll("-","");
                  phonenoCheck=phonenoCheck.substring(6,16);
                  if (phonenoCheck.contains(" ")==false) {
                    SignupModel signmodel = SignupModel(
                        phoneNo: phonenoCheck);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ConfirmOtp(signmodel)));
                  }
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter 10 digits ${phoneController.text} ${phonenoCheck.contains(" ")}")));
                  }
                },
                child: Center(
                  child: Text(
                    "Send",
                    style: TextStyle(
                        fontFamily: 'SF Pro Text',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color:Colors.white),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    primary: ColorManager.green84CC16,
                    minimumSize: Size.fromHeight(DimensionManager.divH(44)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    )
                  //fixedSize: Size(double.infinity, height/18.75)
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
