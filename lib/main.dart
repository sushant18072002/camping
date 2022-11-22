import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:task2/Utilities/color_manager.dart';
import 'package:task2/screen/Menu.dart';
import 'package:task2/screen/edit_profile.dart';
import 'package:task2/screen/location_screen.dart';
import 'package:task2/screen/Login/login.dart';
import 'package:task2/screen/mainmenu.dart';
import 'package:task2/screen/prepare_your_bag.dart';
import 'package:task2/screen/splash.dart';

import 'Model/sign_up_model.dart';
import 'firebase_options.dart';
import 'screen/select_language.dart';
import 'screen/sign_up.dart';
import 'package:localstore/localstore.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Camping',
      theme: ThemeData(
        backgroundColor: ColorManager.white,
        fontFamily: 'SFProText',
      ),
      navigatorKey: navigatorKey,
      home: const SplashScreen(),
    );
  }
}
