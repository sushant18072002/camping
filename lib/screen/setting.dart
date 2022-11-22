import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:task2/CustumWidget/appbarutilies.dart';
import 'package:task2/Utilities/color_manager.dart';
import 'package:task2/Utilities/dimension_manager.dart';
import 'package:task2/Utilities/style_manager.dart';
import 'package:task2/main.dart';
import 'package:task2/screen/recent_trips.dart';

class SettingPage extends KFDrawerContent {

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool flag=false;
  bool isSwitched = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarUtilies.AppbarWithGrid("Settings",widget.onMenuPressed),
      backgroundColor: ColorManager.white,
      body: bodyUi(),
    );
  }

  Widget bodyUi() {
    return Stack(
      children: [
        Padding(
          padding: DimensionManager.fromLTRB(20, 15, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Notifications",
                    style: StyleManager.textWeight400Size16black(),
                  ),
                  SizedBox(
                    width: 51,
                    height: 20,
                    child: CupertinoSwitch(
                      value: isSwitched,
                      activeColor: ColorManager.green84CC16,
                      onChanged: (value) {
                        setState(() {
                          isSwitched = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 24,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(MyApp.navigatorKey.currentContext!,
                      MaterialPageRoute(builder: (context) => RecentTrips()));
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Recent Trips",
                      style: StyleManager.textWeight400Size16black(),
                    ),
                    Text(
                      "Shows you about your past trips history.",
                      style: StyleManager.textWeight400Size12color(
                          ColorManager.colorA1A1AA),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 24,
              ),
              GestureDetector(
                onTap: () {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => alertDialogBox()
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Destroy Trip",
                      style: StyleManager.textWeight400Size16color(
                          ColorManager.colorEA1601),
                    ),
                    Text(
                      "It’ll delete your entire trip history and clear out data.",
                      style: StyleManager.textWeight400Size12color(
                          ColorManager.colorEA1601),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Visibility(
          visible: flag,
          child: Container(
            height: DimensionManager.height,
            width: DimensionManager.width,
            alignment: Alignment.center,
            color: ColorManager.colorcccccc,
            child:  Container(
                height: 200,
                width: 100,
                padding: EdgeInsets.only(top: 100),
                child: CircularProgressIndicator()),
          ),
        )
      ],
    );
  }

  AlertDialog alertDialogBox() {
    return AlertDialog(
      backgroundColor: ColorManager.colorcccccc,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)),
      content: Container(
        height: DimensionManager.divH(122),
        width: DimensionManager.divW(270),
        padding: DimensionManager.onlytop(19),
        decoration: BoxDecoration(
            color: ColorManager.colorcccccc,
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: <Widget>[
            Text('Are you sure?',style:StyleManager.textWeight600Size17black()),
            Padding(
              padding:DimensionManager.topAndBottom(2,17),
              child: Text(
                  'This action will permanently delete all.',style:StyleManager.textweight400size13black()
              ),
            ),
            const Spacer( ),
            Container(
              height: 2,
              child: Divider(
                height: 2,
                color:  ColorManager.colorLine,
                thickness: 1,
              ),
            ),
            Container(
              width: double.infinity,
              height: 42,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context, 'OK'),
                    child: Text(
                      "Cancel",
                      style: StyleManager.textWeight400Size17color(
                          ColorManager.color007AFF),
                    ),
                  ),
                  Container(
                    width: 2,
                    child:  VerticalDivider(color: ColorManager.colorLine,
                      width: 2,
                      thickness: 1,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      deteleData(context);
                    },
                    child: Text(
                      "Delete",
                      style: StyleManager.textWeight400Size17color(
                          ColorManager.color007AFF),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      contentTextStyle: StyleManager.textweight400size13black(),
      contentPadding: EdgeInsets.all(0),
      //actionsPadding: EdgeInsets.all(0),

      /*
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => ,
                      child: const Text('OK'),
                    ),
                  ],
                  */
    );
  }
  deteleData(context) async{
    setState(() {
      flag=true;
    });
    var user=await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid);
    var db = FirebaseFirestore.instance;
    var batch = db.batch();
    var querySnapshotsTrips=await user.collection("trips").get();
    for (var doc in querySnapshotsTrips.docs) {
      await doc.reference.delete();
      batch.delete(doc.reference);
    }
    
    var querySnapshotsActivities = await user.collection("activities").get();
    for (var doc in querySnapshotsActivities.docs) {
      await doc.reference.delete();
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Successfully Deleted")));
    Navigator.pop(context, 'OK');
    setState(() {
      flag=false;
    });
  }

}
