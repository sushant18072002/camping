import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task2/Model/UserModel.dart';
import 'package:task2/Utilities/color_print_logs.dart';
import 'package:task2/main.dart';
import 'package:task2/screen/Login/login.dart';
import 'package:task2/screen/mainmenu.dart';

class LoginRepository{
   BuildContext context=MyApp.navigatorKey.currentContext!;
  Future<void> loginCheck(String emailAddress, String password) async {
    logInfo(FirebaseAuth.instance.currentUser.toString());
    if (FirebaseAuth.instance.currentUser != null) {
      logInfo("reauthenticateWithCredential condition");
      final credential =
      EmailAuthProvider.credential(email: emailAddress, password: password);
      try {
        await FirebaseAuth.instance.currentUser!.reauthenticateWithCredential(
            credential).then((value) {
          logSuccess("Completed Reauthentivation");
          localWrite();
        });
      }
      on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('No user found for that email.')));
          logError('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Wrong password provided for that user.')));
          logError('Wrong password provided for that user.');
        } else {
          logError(e.message.toString());
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(e.message.toString())));
        }
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Login(preSetemail: emailAddress,preSetPassword: password,),));

      }

      /* FirebaseAuth.instance
          .authStateChanges()
          .single
          .then((User? user) {
        if (user == null) {
          logWarning(" loginAuth(emailAddress, password);");
          loginAuth(emailAddress, password);
        } else {
          logWarning(
              "User is signed in! Email password ${emailAddress} ${password}");
          final credential = EmailAuthProvider.credential(
              email: emailAddress, password: password);
          try {
            user.reauthenticateWithCredential(credential).then((value) {
              logSuccess("Successfully ReauthenticateWithCredential");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Menu(),
                  ));
            }).onError((error, stackTrace) {
              logError(error.toString());
            });
          } on FirebaseAuthException catch (e) {
            logError(
                "ReauthenticateWithCredential Error ${e.message.toString()}");
          }
        }
      });*/
    } else {
      logWarning("First time new login (emailAddress, password);");
      loginAuth(emailAddress, password);
    }
  }

  Future<void> loginAuth(String emailAddress, String password) async {
    logInfo("loginAuth(String emailAddress, String password)");
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password)
          .then((value) {
        logSuccess("Completed login");
        localWrite();
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('No user found for that email.')));
        logError('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Wrong password provided for that user.')));
        logError('Wrong password provided for that user.');
      } else {
        logError(e.message.toString());
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message.toString())));
      }

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Login(preSetemail: emailAddress,preSetPassword: password,),));
    }
  }
  localWrite()async {
    var records = await FirebaseFirestore.instance.collection("users").doc(
        FirebaseAuth.instance.currentUser!.uid).get();
    UserModel userModel = UserModel.fromJson(records.data());
    var prefs = await SharedPreferences.getInstance();
    if (userModel.image != Null)
      prefs.setString("profileImage", userModel.image.toString());
    else
      prefs.setString("profileImage", "");
    prefs.setString("username", userModel.name.toString());
    logSuccess("Local Write Successfully ${userModel.toJson().toString()}");
    Get.off(MainMenu());
  }
}