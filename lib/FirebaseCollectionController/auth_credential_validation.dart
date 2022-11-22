import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task2/FirebaseCollectionController/firestore_read_write.dart';
import 'package:task2/Model/sign_up_model.dart';
import 'package:task2/Utilities/color_print_logs.dart';
import 'package:task2/main.dart';
import 'package:task2/screen/Menu.dart';
import 'package:task2/screen/forgot_password.dart';
import 'package:task2/screen/Login/login.dart';
import 'package:task2/screen/mainmenu.dart';
import 'package:task2/screen/new_password.dart';
import 'package:task2/screen/password_changed.dart';
import 'package:task2/screen/registorsuccessfully.dart';

import '../Model/UserModel.dart';

late SignupModel signupModel;

class AuthCredentialValidation {
  BuildContext context = MyApp.navigatorKey.currentContext!;

  initialize(SignupModel signUpModel) {
    signupModel = signUpModel;
  }

  validationCheck(verification,pin) async {
    try {
      await FirebaseAuth.instance
          .signInWithCredential(PhoneAuthProvider.credential(
              verificationId: verification, smsCode: pin))
          .then((value) {
        linkAuthentication();
      }).onError((error, stackTrace) {
        logError("WWWWWWWWWWWWWW UserPin Error ${error.toString()}");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${error.toString()}")));
      });
    } catch (e) {
      FocusScope.of(context).unfocus();
      logError("${e.toString()}");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${e.toString()}")));
    }
  }

  linkAuthentication() async {
    final credential = EmailAuthProvider.credential(
        email: signupModel.email.toString(),
        password: signupModel.password.toString());
    try {
      //final userCredential =
      await FirebaseAuth.instance.currentUser
          ?.linkWithCredential(credential)
          .then((value) async {
        await FireStoreReadWrite().userDataWrite(signupModel);

        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>ResgistorSuccessfull(),
            ));
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        logWarning('The password provided is too weak.');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('The password provided is too weak.')));
      } else if (e.code == 'email-already-in-use') {
        logWarning('The account already exists for that email.');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('The account already exists for that email.')));
      }
    } catch (e) {
      logError(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }


  Future<void> updatePassword(String password){
    password=password.trim();
    return FirebaseAuth.instance.currentUser!.updatePassword(password).then((value) {
      logSuccess("Successfully Updated password ${password}");
    }).onError((error, stackTrace) {
      logError(" UpdatePasswordError ${error.toString()} ");
    });
  }

}

/*
class TryBuild extends StatelessWidget {
  TryBuild({Key? key}) : super(key: key);
  String _value = "Hi";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Try"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Chating"),
            Text("${_value}"),
            Center(
              child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return Column(
                    children: [
                      Text("${_value}"),
                      ElevatedButton(
                        onPressed: () {
                          print("click 8888888");
                          setState(() {
                            _value = "bolo jiii";
                          });
                        },
                        child: Text("Reply"),
                      )
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/
