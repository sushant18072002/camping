import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:task2/CustumWidget/appbarutilies.dart';
import 'package:task2/CustumWidget/button_ui.dart';
import 'package:task2/FirebaseCollectionController/auth_credential_validation.dart';
import 'package:task2/Model/sign_up_model.dart';
import 'package:task2/Utilities/color_manager.dart';
import 'package:task2/Utilities/color_print_logs.dart';
import 'package:task2/Utilities/dimension_manager.dart';
import 'package:task2/Utilities/style_manager.dart';

import 'new_password.dart';

class ConfirmOtp extends StatefulWidget {
  SignupModel signupModel;

  ConfirmOtp(this.signupModel);

  @override
  State<ConfirmOtp> createState() => _ConfirmOtpState();
}

class _ConfirmOtpState extends State<ConfirmOtp> {
  late String verification;
  TextEditingController pinController=TextEditingController();
  bool flag=true;

  @override
  void initState() {
    super.initState();
    //verifyPhone();
    AuthCredentialValidation().initialize(widget.signupModel);
    verifyPhone();
  }


  @override
  void dispose() {
    super.dispose();
    pinController.dispose();
  }

  late String _pin="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarUtilies.appbarUtil("Confirm OTP"),
        body: bodyUi(context));
  }

  Widget bodyUi(context) {

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: ColorManager.colorF4F4F5,
        borderRadius: BorderRadius.circular(20),
      ),
      textStyle: StyleManager.textWeight400Size24color(ColorManager.green84CC16)
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
        textStyle: StyleManager.textWeight400Size24color(ColorManager.green84CC16)
    );
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: DimensionManager.fromLTRB(20, 24, 24),
              child: RichText(
                text: TextSpan(
                  text:
                      "Please confirm your 6 digit OTP. which is\nsent on this number ${widget.signupModel.phoneNo} ",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Color(0xff71717A)),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Change number.',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            ),
            Padding(
                padding: DimensionManager.onlytop(40),
                child: Pinput(
                  controller: pinController,
                  length: 6,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  submittedPinTheme: focusedPinTheme,
                  onSubmitted: (pin){
                    _pin=pin;
                   // validationCheck(pin);
                  },
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  showCursor: true,
                  onCompleted: (pin) { print("!!!!!!!!!!!! pin${pin}");
                    _pin=pin;
                    },
                ),),
            Padding(
                padding: DimensionManager.fromLTRB(40, 48, 40),
                child: ButtonUi.filledbuttonCustumWithFunction(validatedPin, "Send"),),

          ],
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
  validatedPin() async{
    setState(() {
      flag=true;
    });
    await AuthCredentialValidation().validationCheck(verification,_pin);
    setState(() {
      flag=false;
    });
  }
  setFalseState(){
    setState(() {
      flag=false;
    });
  }
  setTrueState(){
    setState(() {
      flag=false;
    });
  }


  verifyPhone() async {
    logInfo(widget.signupModel.toJson().toString());
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+91${signupModel.phoneNo.toString().trim()}",
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((value) {
          if (value.user != null) {
            logSuccess('user logged in');
            if(signupModel.name!=null) {
              AuthCredentialValidation().linkAuthentication();
            }
            else{
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NewPassword(),));
            }

          }
        }).onError((error, stackTrace) {
          logError("III Autopin Error ${error.toString()}");
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${error.toString()}")));
          setFalseState();
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        logError("???????????????????? SelfVerify Error ${e.message}");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${e.message.toString()}")));
        setFalseState();
      },
      codeSent: (String verificationId, int? resendToken) {
        //print("@@@@@@@@@@@ codeSent ${verificationId}");
        verification = verificationId;
        setFalseState();
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        verification = verificationId;
        setFalseState();
      },
    );

  }


}
