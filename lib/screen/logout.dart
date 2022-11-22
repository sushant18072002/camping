import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:task2/CustumWidget/appbarutilies.dart';
import 'package:task2/Utilities/color_manager.dart';
import 'package:task2/Utilities/color_print_logs.dart';
import 'package:task2/Utilities/dimension_manager.dart';
import 'package:task2/Utilities/style_manager.dart';
import 'package:task2/Utilities/color_manager.dart';
import 'package:task2/screen/Login/login.dart';

class LogOut extends KFDrawerContent {
  _LogOut createState() => _LogOut();
}
class _LogOut extends State<LogOut> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBarUtilies.AppbarWithGrid("Log-out",widget.onMenuPressed),
      body: bodyUi(context),
    );
  }
   Widget bodyUi(context) {
    return Column(
      children: [
         Padding(
           padding: DimensionManager.onlytop(10),
           child: Text(
            "Logging out will remove your access from \nthis device. And clean your past data. are\nyou still sure want to log-out?",
            style:
                StyleManager.textWeight400Size16Color(ColorManager.color71717A),
        ),
         ),
        Container(
          margin: const EdgeInsets.all(20.0),
          height: 44,
          child: ElevatedButton(
            onPressed: () {
              logSuccess("logut");
              logOut();
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) =>   _signOut()));
            },
            style: ElevatedButton.styleFrom(
                primary: ColorManager.colorEA1601,
                minimumSize: Size.fromHeight(DimensionManager.divH(44)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                )
                //fixedSize: Size(double.infinity, height/18.75)
                ),
            child: Text(
              "Logout",
              style: StyleManager.textWeight500Size14black(),
            ),
          ),
        )
      ],
    );
  }
  Future logOut() async {
    await FirebaseAuth.instance.signOut().then((value) => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Login(),), (route) => false));
  }
}
