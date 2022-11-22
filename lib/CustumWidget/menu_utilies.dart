import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task2/Utilities/color_manager.dart';
import 'package:task2/Utilities/dimension_manager.dart';
import 'package:task2/Utilities/style_manager.dart';
import 'package:task2/screen/activities.dart';
import 'package:task2/screen/add_trip.dart';
import 'package:task2/screen/catchsnaps.dart';
import 'package:task2/screen/exittrip.dart';
import 'package:task2/screen/feedback.dart';
import 'package:task2/screen/how_to_use.dart';
import 'package:task2/screen/logout.dart';
import 'package:task2/screen/notiFication.dart';
import 'package:task2/screen/select_language.dart';
import 'package:task2/screen/setting.dart';
import 'package:task2/screen/tips_and_tricks.dart';

class MenuUtilies{
  static MenuItems(){
    return  KFDrawerController(
      initialPage: AddTrip(),
      items: [
        KFDrawerItem.initWithPage(
          icon: Container(
            margin: DimensionManager.onlytop(20),
            padding: DimensionManager.fromLTRB(19,14,24,14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment:  MainAxisAlignment.start,
              children: [
                Padding(
                  padding: DimensionManager.fromLTRB(19, 0, 19),
                  child: Image.asset(
                    "assets/images/home.png",
                    height: 24,
                    width: 24,
                  ),
                ),
                Text(
                  "Home",
                  style: TextStyle(
                    fontFamily: 'SF Pro Text',
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Color(0xff365314),
                  ),
                ),
              ],
            ),
          ),
          page: AddTrip(),
        ),
        KFDrawerItem.initWithPage(
          text: Container(
            margin: DimensionManager.fromLTRB(0, 0),
            child: Row(
              children: [
                Padding(
                  padding: DimensionManager.onlyleft(16),
                  child: Text(
                    'How To use',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          ),
          icon: Image.asset(
            "assets/images/question_mark.png",
            height: 24,
            width: 24,
          ),
            page: HowToUse(),
        ),
        KFDrawerItem.initWithPage(
          text: Container(
            padding: DimensionManager.fromLTRB(18, 0),
            child: Text(
              'Language',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
          ),
          icon: Container(
            padding: DimensionManager.fromLTRB(0, 0),
            child: Image.asset(
              "assets/images/globe-2.png",
              height: 24,
              width: 24,
            ),
          ),
          page: SelectLangauge(),
        ),
        KFDrawerItem.initWithPage(
          text: Row(
            children: [
              Padding(
                padding: DimensionManager.fromLTRB(19, 0),
                child: Text(
                  'Log-out',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
          icon: Container(
            padding: DimensionManager.fromLTRB(0, 0),
            child: Image.asset(
              "assets/images/log_out.png",
              height: 24,
              width: 24,
            ),
          ),
          page: LogOut(),
        ),
      ],
    );
  }
  static MianMenuItems(){
    var style=StyleManager.textWeight400Size16Color(ColorManager.colorECFCCB);
    return  KFDrawerController(
      initialPage: ActivitiesScreen(),
      items: [
        KFDrawerItem.initWithPage(
          icon: Container(
            margin: DimensionManager.onlytop(20),
            width: DimensionManager.divW(125),
            height: DimensionManager.divH(48),
            decoration: BoxDecoration(
              color: ColorManager.white,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: DimensionManager.fromLTRB(19, 0, 19),
                  child: Image.asset(
                    "assets/images/home.png",
                    height: 24,
                    width: 24,
                  ),
                ),
                Text(
                  "Home",
                  style:StyleManager.textWeight400Size16Color(ColorManager.color365314),
                  ),
              ],
            ),
          ),
          page: ActivitiesScreen(),
        ),
        KFDrawerItem.initWithPage(
          text: Container(
            margin: DimensionManager.fromLTRB(0, 0),
            child: Padding(
              padding: DimensionManager.onlyleft(16),
              child: Text(
                'Tips & Tricks',
                style:style),
              ),
          ),
          icon: Image.asset(
            "assets/icons/bulb.png",
            height: 24,
            width: 24,
          ),
          page: TipsAndTricks(),
        ),
        KFDrawerItem.initWithPage(
          text: Container(
            padding: DimensionManager.fromLTRB(18, 0),
            child: Text(
              'Notifications',
              style: style,
            ),
          ),
          icon: Container(
            padding: DimensionManager.fromLTRB(0, 0),
            child: Image.asset(
              "assets/icons/belllight.png",
              height: 24,
              width: 24,
            ),
          ),
          page: NotiFication(),
        ),
        KFDrawerItem.initWithPage(
          text: Padding(
            padding: DimensionManager.fromLTRB(19, 0),
            child: Text(
              'Catch Snaps',
              style: style,
            ),
          ),
          icon: Container(
            padding: DimensionManager.fromLTRB(0, 0),
            child: Image.asset(
              "assets/icons/cameraicon.png",
              height: 24,
              width: 24,
            ),
          ),
          page: CatchSnaps(),
        ),
        KFDrawerItem.initWithPage(
          text: Padding(
            padding: DimensionManager.fromLTRB(19, 0),
            child: Text(
              'Settings',
              style: style,
            ),
          ),
          icon: Container(
            padding: DimensionManager.fromLTRB(0, 0),
            child: Image.asset(
              "assets/icons/settings.png",
              height: 24,
              width: 24,
            ),
          ),
          page: SettingPage(),
        ),
        KFDrawerItem.initWithPage(
          text: Padding(
            padding: DimensionManager.fromLTRB(19, 0),
            child: Text(
              'Feedback',
              style: style,
            ),
          ),
          icon: Container(
            padding: DimensionManager.fromLTRB(0, 0),
            child: Image.asset(
              "assets/icons/message-square.png",
              height: 24,
              width: 24,
            ),
          ),
          page: FeedBack(),
        ),
        KFDrawerItem.initWithPage(
          text: Container(
            margin: DimensionManager.fromLTRB(0, 0),
            child: Row(
              children: [
                Padding(
                  padding: DimensionManager.onlyleft(16),
                  child: Text(
                    'How To use',
                    style: style,
                  ),
                ),
              ],
            ),
          ),
          icon: Image.asset(
            "assets/images/question_mark.png",
            height: 24,
            width: 24,
          ),
          page: HowToUse(),
        ),
        KFDrawerItem.initWithPage(
          text: Container(
            padding: DimensionManager.fromLTRB(18, 0),
            child: Text(
              'Language',
              style: style,
            ),
          ),
          icon: Container(
            padding: DimensionManager.fromLTRB(0, 0),
            child: Image.asset(
              "assets/images/globe-2.png",
              height: 24,
              width: 24,
            ),
          ),
          page: SelectLangauge(),
        ),
        KFDrawerItem.initWithPage(
          text: Row(
            children: [
              Padding(
                padding: DimensionManager.fromLTRB(19, 0),
                child: Text(
                  'Log-out',
                  style: style,
                ),
              ),
            ],
          ),
          icon: Container(
            padding: DimensionManager.fromLTRB(0, 0),
            child: Image.asset(
              "assets/images/log_out.png",
              height: 24,
              width: 24,
            ),
          ),
          page: LogOut(),
        ),
      ],
    );
  }

}