import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task2/Utilities/color_manager.dart';
import 'package:task2/Utilities/dimension_manager.dart';
import 'package:task2/Utilities/image_manager.dart';
import 'package:task2/Utilities/string_manager.dart';
import 'package:task2/Utilities/style_manager.dart';
import 'package:task2/screen/mainmenu.dart';

import 'dart:async';
import 'package:task2/screen/onboarding.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreen createState() => _SplashScreen();
}
class _SplashScreen extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2),
            (){
      if(FirebaseAuth.instance.currentUser==null)
      Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                const Onboarding()
            )
        );
      else{
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
            const MainMenu()
            )
        );
      }
    }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        backgroundColor:ColorManager.green84CC16,
      body: bodyUi()
    );
  }
  Widget bodyUi(){
   return Center(
     child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(ImageManager.splashImageLink1,
            height: DimensionManager.divH(63),
            width: DimensionManager.divW(295),
          ),
          Padding(
            padding: DimensionManager.onlytop(8),
            child: Text( StringManager.splashString1,
                style: StyleManager.textWeight400Size16White()
            ),
          )
        ],
      ),
   );
  }
}
