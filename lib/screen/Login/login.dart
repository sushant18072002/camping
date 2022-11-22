import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task2/CustumWidget/button_ui.dart';
import 'package:task2/CustumWidget/textfield_ui.dart';
import 'package:task2/FirebaseCollectionController/auth_credential_validation.dart';
import 'package:task2/Model/UserModel.dart';
import 'package:task2/Model/sign_up_model.dart';
import 'package:task2/Utilities/color_manager.dart';
import 'package:task2/Utilities/color_print_logs.dart';
import 'package:task2/Utilities/dimension_manager.dart';
import 'package:task2/Utilities/style_manager.dart';
import 'package:task2/screen/Login/repository.dart';
import 'package:task2/screen/Menu.dart';
import 'package:task2/screen/mainmenu.dart';
import 'package:task2/screen/sign_up.dart';

import '../forgot_password.dart';

class Login extends StatefulWidget {
  String? preSetemail;
  String? preSetPassword;

  Login({this.preSetemail, this.preSetPassword});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool flagLogin = false;

  @override
  void initState() {
    super.initState();
    if (widget.preSetemail != null) {
      emailController.text = widget.preSetemail!;
    }
    if (widget.preSetPassword != null) {
      passwordController.text = widget.preSetPassword!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: bodyUi(context),
    );
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  Widget bodyUi(context) {
    return Stack(
      children: [
        Padding(
          padding: DimensionManager.fromLTRB(40, 167, 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("assets/images/Logodark.png"),
              Column(
                children: [
                  textFieldWithLabel("Email", emailController, false),
                  textFieldWithLabel("Password", passwordController, true),
                ],
              ),
              Padding(
                padding: DimensionManager.onlytop(16),
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ForgotPassword(),
                          ));
                    },
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: ColorManager.colorA1A1AA,
                          height: 24 / 16),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: DimensionManager.fromLTRB(40, 24, 40),
                child: filledbuttonCustumWithFunction("Login"),
              ),
              Padding(
                padding: DimensionManager.fromLTRB(40, 24, 40),
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUp(),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    primary: ColorManager.green84CC16,
                    minimumSize: Size.fromHeight(
                      DimensionManager.divH(44),
                    ),
                    side: BorderSide(
                      color: ColorManager.green84CC16,
                      width: 1.5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text(
                    "Register",
                    style: StyleManager.textWeight500Size14Color(
                        ColorManager.green84CC16),
                  ),
                ),
              ),
            ],
          ),
        ),
        Visibility(
          visible: flagLogin,
          child: Container(
            height: DimensionManager.height,
            width: DimensionManager.width,
            alignment: Alignment.center,
            color: ColorManager.colorcccccc,
            child: const SizedBox(
                height: 100, width: 100, child: CircularProgressIndicator()),
          ),
        )
      ],
    );
  }

  Widget textFieldWithLabel(
      String text, TextEditingController controller, bool flag) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
        ),
        Text(text,
            style: StyleManager.textWeight400Size16Color(
                ColorManager.color71717A)),
        Container(
          margin: DimensionManager.onlytop(8),
          height: DimensionManager.divH(48),
          child: TextFormField(
            controller: controller,
            onEditingComplete: () {
              print(controller.text);
            },
            obscureText: flag,
            style: StyleManager.textWeight400Size16black(),
            decoration: InputDecoration(
              filled: true,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget filledbuttonCustumWithFunction(text) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          flagLogin = true;
        });
        VidationNavigate();
      },
      style: ElevatedButton.styleFrom(
          primary: ColorManager.green84CC16,
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

  VidationNavigate() async {
    await LoginRepository()
        .loginCheck(emailController.text.trim(), passwordController.text);
  }
}
