import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:task2/Utilities/color_manager.dart';
import 'package:task2/Utilities/dimension_manager.dart';
import 'package:task2/screen/add_trip.dart';
import 'package:task2/screen/edit_profile.dart';
import 'package:task2/screen/forgot_password.dart';
import 'package:task2/screen/main_page.dart';
import 'package:task2/screen/splash.dart';

import '../CustumWidget/menu_utilies.dart';

class Menu extends StatefulWidget {
  Menu({Key? key}) : super(key: key);

  @override
  _Menu createState() => _Menu();
}

class _Menu extends State<Menu> with TickerProviderStateMixin {
  late KFDrawerController _drawerController;

  @override
  void initState() {
    super.initState();
    //DimensionManager().initialize();
    _drawerController =MenuUtilies.MenuItems();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: bodyUi()
    );
  }
  Widget bodyUi(){
    return  KFDrawer(
      menuPadding: const EdgeInsets.all(0),
      controller: _drawerController,
      header: Container(
        padding: DimensionManager.fromLTRB(20, 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/Avatar.png',
              height: DimensionManager.divH(64),
              width: DimensionManager.divW(64),
              alignment: Alignment.topRight,
            ),
            Padding(
              padding: DimensionManager.onlytop(11.8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: DimensionManager.onlyright(20),
                    child: Text(
                      "Will Smith",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile(),));
                    },
                    child: ImageIcon(
                      AssetImage("assets/icons/edit.png"),
                      color: Colors.white,
                      size: 24,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      footer: Container(
      ),
      decoration: BoxDecoration(color: ColorManager.drawer65A30D),
    );
  }
}
