import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task2/CustumWidget/button_ui.dart';
import 'package:task2/Utilities/color_manager.dart';
import 'package:task2/Utilities/color_print_logs.dart';
import 'package:task2/Utilities/dimension_manager.dart';
import 'package:task2/Utilities/style_manager.dart';
import 'package:task2/main.dart';
import 'package:task2/screen/Menu.dart';
import 'package:task2/screen/add_trip.dart';
import 'package:task2/screen/add_trip_form.dart';
import 'package:task2/screen/confirm_otp.dart';
import 'package:task2/screen/Login/login.dart';

import '../Model/sign_up_model.dart';
import 'forgot_password.dart';

class SignUp extends StatefulWidget {
   SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
     TextEditingController _nameController = TextEditingController();

     TextEditingController _emailController = TextEditingController();

     TextEditingController _phoneController = TextEditingController();

     TextEditingController _passwordController = TextEditingController();

     @override
  void dispose() {
       super.dispose();
       _nameController.dispose();
       _emailController.dispose();
       _phoneController.dispose();
       _passwordController.dispose();
     }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      body: bodyUi(),
    );
  }

  Widget bodyUi(){
    return Padding(
      padding: DimensionManager.fromLTRB(40,0,40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 99,),
          Image.asset("assets/images/Logodark.png", fit: BoxFit.cover),
          SizedBox(height: 20,),
          textFieldWithLabel("Name",_nameController,false,""),
          textFieldWithLabel("Email",_emailController,false,""),
          textFieldWithLabel("Phone",_phoneController,false,""),
          textFieldWithLabel("Password",_passwordController,true,""),
          SizedBox(height: 24,),
          ButtonUi.filledbuttonCustumWithFunction(NavigateScreen, "Register"),
          SizedBox(height: 20,),
          ButtonUi.outlineButtonCustum(Login(), "Login",44),
        ],
      ),
    );
  }

  Widget textFieldWithLabel(String text,TextEditingController controller,bool flag,String initialValue){
    return   Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20,),
        Text(
            text,
            style: StyleManager.textWeight400Size16Color(ColorManager.color71717A)
        ),
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

    NavigateScreen(){
      if(_nameController.text.trim()==null||_nameController.text.trim()==""|| _emailController.text.trim()==null|| _emailController.text==""||_phoneController.text.trim()==""|| _passwordController.text.trim()==null||_passwordController.text.isEmpty){
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Please fill all feild")));
      }
      else if(_passwordController.text.trim().length<6){
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Please change your password because it is weak.")));
      }
      else{
        Navigator.push(
            MyApp.navigatorKey.currentContext!,
            MaterialPageRoute(builder: (context) => ConfirmOtp(dataSend())));
      }

   }

  dataSend(){
    SignupModel signupModel=SignupModel(name: _nameController.text.trim(),email: _emailController.text.trim(),phoneNo: _phoneController.text.trim(),password: _passwordController.text.trim(),description:"");
    return signupModel;
  }
}
