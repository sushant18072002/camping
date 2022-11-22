import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:task2/CustumWidget/appbarutilies.dart';
import 'package:task2/FirebaseCollectionController/storage_service.dart';
import 'package:task2/Model/CatchSnapModel.dart';
import 'package:task2/Utilities/color_manager.dart';
import 'package:task2/Utilities/color_print_logs.dart';
import 'package:task2/Utilities/dimension_manager.dart';
import 'package:task2/Utilities/style_manager.dart';
import 'package:task2/screen/carmera_page.dart';

class CatchSnaps extends KFDrawerContent {
   int? selectCamera;
  CatchSnaps({this.selectCamera});

  @override
  State<CatchSnaps> createState() => _CatchSnapsState();

}

class _CatchSnapsState extends State<CatchSnaps> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBarUtilies.AppbarWithGrid(
          "Catch Snaps.", widget.onMenuPressed),
      body: conditionForBodyUi(context),
      // body: widget.imagePaths == null ? emptybodyUi(context) : bodyUiGrid(
      //     context),
    );
  }

    Widget conditionForBodyUi(context) {
    CollectionReference users = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("activity");
    //Future<DocumentSnapshot> doc= users.get();
    //doc.docs.isEmpty
    //users.doc(FirebaseAuth.instance.currentUser!.uid).collection("activity").snapshots(),
    return StreamBuilder<ListResult>(
      stream:StorageService().ListFiles().asStream(),
      builder: (BuildContext context, AsyncSnapshot<ListResult> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && snapshot.data?.items.length ==null) {
          logWarning("Empty list");
          return emptybodyUi(context);
        }

        if (snapshot.data?.items.length != null) {
          logSuccess("List print```");

          List<String> itemList=[];
          snapshot.data!.items.forEach((element) {
            itemList.add(element.name);
          });
          return bodyUiGrid(context,itemList);
        }

        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: DimensionManager.height,
          child: Shimmer.fromColors(
            child: Card(
              color: Colors.grey,
            ),
            baseColor: Colors.white70,
            highlightColor:ColorManager.colorA1A1AA,
            direction: ShimmerDirection.ltr,
          ),
        );
      },
    );
  }
    Widget emptybodyUi(context) {
    return SizedBox(
      width: DimensionManager.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: DimensionManager.divH(150),
          ),
          Image.asset(
            "assets/images/onboarding1.png",
            width: 177,
            height: 180,
          ),
          Padding(
            padding: DimensionManager.topAndBottom(24, 16),
            child: Text(
              "You didn’t catch any snaps yet.",
              style: StyleManager.textWeight400Size16Color(
                  ColorManager.color3F3F46),
            ),
          ),
          SizedBox(
            width: DimensionManager.divW(111),
            child:
            OutlineButtonCustum(context,CameraSnap(), "Click Snaps", 45),
          )
        ],
      ),
    );
  }
  navigateCamera () async {
    await availableCameras().then(
          (value) =>
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  CameraSnap(
                    cameras: value,
                    selectCamera: widget.selectCamera!,
                  ),
            ),
          ),
    );
  }
    Widget bodyUiGrid(context,List<String> listResult) {
    final double itemHeight = DimensionManager.divH(240) / 2;
    final double itemWidth = DimensionManager.divW(150) / 2;
    return Stack(
      children: [
        Padding(
          padding: DimensionManager.fromLTRB(20, 10, 20),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "14 Feb 2020",
                  style: StyleManager.textWeight400Size12color(
                      ColorManager.colorA1A1AA),
                ),
                GridView.count(
                    padding: DimensionManager.onlytop(16),
                    crossAxisCount: 2,
                    childAspectRatio: (itemWidth / itemHeight),
                    controller: ScrollController(keepScrollOffset: true),
                    physics:BouncingScrollPhysics(),
                    shrinkWrap: true,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 24,
                    scrollDirection: Axis.vertical,
                    children: List.generate(
                      (listResult.length + 1),
                          (index) {
                        if (index == listResult.length) {
                          return plusButton(context);
                        } else {
                          return  imageReader(listResult[index]);
                        }
                      },
                    ))
              ],
            ),
          ),
        ),
        Container(
          height: DimensionManager.height,
          width: DimensionManager.width,
          alignment: Alignment.bottomCenter,
          padding: DimensionManager.fromLTRB(20,0,20,18),
          child: SizedBox(
              height: 45,
              child: filledbutton(
                context,
                "Click New Snap",
              )),
        ),
      ],
    );
  }
  Widget imageReader(String image){
    return FutureBuilder(
        future: StorageService().downloadUrl(image),
        builder:((context, AsyncSnapshot<String>snapshot) {
          logSuccess(image);
          if(snapshot.connectionState==ConnectionState.done&&snapshot.hasData){
            return ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(snapshot.data!,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Shimmer.fromColors(
                    child: Card(
                      color: Colors.grey,
                    ),
                    baseColor: Colors.white70,
                    highlightColor:ColorManager.colorA1A1AA,
                    direction: ShimmerDirection.ltr,
                  );
                },
                width: 155,
                height: 240,
                fit: BoxFit.cover,
              ),
            );
          }
          if(snapshot.connectionState==ConnectionState.waiting||!snapshot.hasData){
            return Shimmer.fromColors(
              child: Card(
                color: Colors.grey,
              ),
              baseColor: Colors.white70,
              highlightColor:ColorManager.colorA1A1AA,
              direction: ShimmerDirection.ltr,
            );
          }
          return Shimmer.fromColors(
          child: Card(
          color: Colors.grey,
          ),
          baseColor: Colors.white70,
          highlightColor:ColorManager.colorA1A1AA,
          direction: ShimmerDirection.ltr,
          );
        }));
  }

    Widget plusButton(context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: ColorManager.colorF4F4F5,
          borderRadius: BorderRadius.circular(15)),
      child: Image.asset(
        "assets/icons/plus.png",
        width: 24,
        height: 24,
      ),
    );
  }

  Widget filledbutton(context, text) {
    return ElevatedButton(
      onPressed: () async {
        await availableCameras().then(
              (value) =>
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CameraSnap(
                        cameras: value,
                        selectCamera: widget.selectCamera==null?0:widget.selectCamera,
                      ),
                ),
              ),
        );
      },
      style: ElevatedButton.styleFrom(
          primary: ColorManager.green84CC16,
          minimumSize: Size.fromHeight(DimensionManager.divH(44)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          )
        //fixedSize: Size(double.infinity, height/18.75)
      ),
      child: Text(
        text,
        style: StyleManager.textWeight500Size14black(),
      ),
    );
  }

    Widget OutlineButtonCustum(context, classname, text, height) {
    return OutlinedButton(
      onPressed: () async {
        await availableCameras().then(
              (value) => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CameraSnap(
                cameras: value,
                selectCamera: 0,
              ),
            ),
          ),
        );
      },
      style: OutlinedButton.styleFrom(
          primary: ColorManager.green84CC16,
          minimumSize:
          Size.fromHeight(DimensionManager.divH(height.toDouble())),
          side: BorderSide(
            color: ColorManager.green84CC16,
            width: 1.5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          )
        //fixedSize: Size(double.infinity, height/18.75)
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
              fontFamily: 'SF Pro Text',
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: ColorManager.green84CC16),
        ),
      ),
    );
  }
  setChange(){
    FirebaseStorage.instance.ref('users/${FirebaseAuth.instance.currentUser!.uid}/Catchsnaps').listAll().asStream().listen((event) {
      setState(() {
      });
    });
  }
  @override
  void initState() {
    super.initState();
    setChange();
    if(widget.selectCamera==null){
      widget.selectCamera=0;
    }
  }
}

