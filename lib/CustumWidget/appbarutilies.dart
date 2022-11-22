import 'package:flutter/material.dart';
import 'package:task2/Utilities/color_manager.dart';
import 'package:task2/Utilities/dimension_manager.dart';
import 'package:task2/Utilities/style_manager.dart';
import 'package:task2/main.dart';
import 'package:task2/screen/mainmenu.dart';

class AppBarUtilies {
  static AppBar appbarUtil(String text) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        text,
        style: TextStyle(
            color: ColorManager.black,
            fontWeight: FontWeight.w500,
            fontSize: 20),
      ),
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(MyApp.navigatorKey.currentContext!);
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 8, 0),
          child: Image.asset(
            "assets/icons/chevronleft.png",
            height: 32,
            width: 32,
          ),
        ),
      ),
      leadingWidth: 60,
      titleSpacing: 0,
      backgroundColor: ColorManager.white,
      elevation: 0,
    );
  }

  static AppBar appbarUtilWithClassNavitor(String text,classname) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        text,
        style: TextStyle(
            color: ColorManager.black,
            fontWeight: FontWeight.w500,
            fontSize: 20),
      ),
      leading: GestureDetector(
        onTap: () {
          BuildContext context=MyApp.navigatorKey.currentContext!;
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => classname,), (route) => false);
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 8, 0),
          child: Image.asset(
            "assets/icons/chevronleft.png",
            height: 32,
            width: 32,
          ),
        ),
      ),
      leadingWidth: 60,
      titleSpacing: 0,
      backgroundColor: ColorManager.white,
      elevation: 0,
    );
  }

  static AppBar appbarUtilWithRightIcon(String text, String rightIcon) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        text,
        style: TextStyle(
            color: ColorManager.black,
            fontWeight: FontWeight.w500,
            fontSize: 20),
      ),
      leading: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 8, 0),
        child: GestureDetector(
          onTap: (){
            Navigator.pop(MyApp.navigatorKey.currentContext!);
          },
          child: Image.asset(
            "assets/icons/chevronleft.png",
            height: 32,
            width: 32,
          ),
        ),
      ),
      leadingWidth: 60,
      titleSpacing: 0,
      backgroundColor: ColorManager.white,
      elevation: 0,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Image.asset(
            rightIcon,
            height: 32,
            width: 32,
          ),
        )
      ],
    );
  }
  static AppBar appbarUtilWithRightText(String text, String rightText) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        text,
        style: TextStyle(
            color: ColorManager.black,
            fontWeight: FontWeight.w500,
            fontSize: 20),
      ),
      leading: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 8, 0),
        child: GestureDetector(
          onTap: (){
            Navigator.pop(MyApp.navigatorKey.currentContext!);
          },
          child: Image.asset(
            "assets/icons/chevronleft.png",
            height: 32,
            width: 32,
          ),
        ),
      ),
      leadingWidth: 60,
      titleSpacing: 0,
      backgroundColor: ColorManager.white,
      elevation: 0,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20.0,top: 20.0),
          child: Text(rightText,style: StyleManager.textWeight500Size14Color(ColorManager.colorA1A1AA),)
        )
      ],
    );
  }

  static AppBar AppbarWithGrid(String text, function) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        text,
        style: StyleManager.textweight600size20black(),
      ),
      leading: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 8, 0),
        child: GestureDetector(
          onTap: function,
          child: Image.asset(
            "assets/icons/grid.png",
            height: 24,
            width: 24,
          ),
        ),
      ),
      centerTitle: true,
      leadingWidth: 60,
      backgroundColor: ColorManager.white,
      elevation: 0,
    );
  }

  static AppBar AppbarWithGridAndRigthIcon(
      String text, String imageName, functionLeftIcon,functionRightIcon) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        text,
        style: StyleManager.textweight600size20black(),
      ),
      leading: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 8, 0),
        child: GestureDetector(
          onTap: functionLeftIcon,
          child: Image.asset(
            "assets/icons/grid.png",
            height: 24,
            width: 24,
          ),
        ),
      ),
      centerTitle: true,
      leadingWidth: 60,
      backgroundColor: ColorManager.white,
      elevation: 0,
      actions: [
        GestureDetector(
          onTap: (){
            functionRightIcon();
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Image.asset(
              imageName,
              height: 32,
              width: 32,
            ),
          ),
        )
      ],
    );
  }

  static AppBar AppbarWithGridAndRigthIconBellIcon(String text, function) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        text,
        style: StyleManager.textweight600size20black(),
      ),
      leading: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 8, 0),
        child: GestureDetector(
          onTap: function,
          child: Image.asset(
            "assets/icons/grid.png",
            height: 24,
            width: 24,
          ),
        ),
      ),
      centerTitle: true,
      leadingWidth: 60,
      backgroundColor: ColorManager.white,
      elevation: 0,
      actions: [
        Padding(padding: const EdgeInsets.only(top: 10), child: bellIcon()),
      ],
    );
  }

  static Widget bellIcon() {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(right: 20),
          child: Image.asset(
            "assets/icons/bell.png",
            height: 32,
            width: 32,
          ),
        ),
        Container(
            height: 16,
            width: 16,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: ColorManager.bellGround, shape: BoxShape.circle),
            child: Text(
              "1",
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: ColorManager.color365314),
            )),
      ],
    );
  }
}
