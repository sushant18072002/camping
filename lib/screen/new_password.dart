import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:task2/CustumWidget/appbarutilies.dart';
import 'package:task2/FirebaseCollectionController/auth_credential_validation.dart';
import 'package:task2/screen/password_changed.dart';
double width = 0.0;
double height = 0.0;

class NewPassword extends StatefulWidget {
  const NewPassword({Key? key}) : super(key: key);

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  TextEditingController passwordController=TextEditingController();

  @override
  void dispose() {
    super.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarUtilies.appbarUtil("New Password"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(divW(20), divH(24), divW(20), 0),
            child: Text(
              "Enter your new password below and please don’t forget it now. it’s important to you to remember your password.",
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: Color(0xff71717A)),
              textAlign: TextAlign.justify,
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.fromLTRB(
                divW(40), divH(24), 0, 0),
            child: Text(
              "Set Password",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff71717A)),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
                divW(40), divH( 8), divW(40), 0),
            child: Container(
              height: divH(48),
              child: TextFormField(
                obscureText: true,
                controller: passwordController,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                decoration: InputDecoration(
                  filled: true,
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
            padding: EdgeInsets.fromLTRB(divW(40),divH(48),divH(40),0),
            child: ElevatedButton(
              onPressed: () {
                AuthCredentialValidation().updatePassword(passwordController.text).then((value) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const PasswordChanged()));
                });
              },
              child: Center(
                child: Text(
                  "Send",
                  style: TextStyle(
                    fontFamily: 'SF Pro Text',
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Color(0xffFFFFFF),
                  ),
                ),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Color(0xff84CC16),
                  minimumSize: Size.fromHeight(divH(44)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  )
                //fixedSize: Size(double.infinity, height/18.75)
              ),
            ),
          ),
        ],
      ),
    );
  }
}

double divW(double value) {
  return width / (width / value);
}

double divH(double value) {
  return height / (height / value);
}
