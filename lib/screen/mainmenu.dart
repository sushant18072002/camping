import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:task2/CustumWidget/menu_utilies.dart';
import 'package:task2/Model/UserModel.dart';
import 'package:task2/Utilities/color_manager.dart';
import 'package:task2/Utilities/color_print_logs.dart';
import 'package:task2/Utilities/dimension_manager.dart';
import 'package:task2/Utilities/style_manager.dart';
import 'package:task2/main.dart';
import 'package:task2/screen/edit_profile.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> with TickerProviderStateMixin {
  late KFDrawerController _drawerController;

  @override
  void initState() {
    super.initState();
    _drawerController =MenuUtilies.MianMenuItems();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: ColorManager.white,
        body:bodyUi()//pageList[selectedIndex],
    );
  }
  Widget bodyUi() {
    return KFDrawer(
      menuPadding: const EdgeInsets.all(0),
      controller: _drawerController,
      header: Container(
        padding: DimensionManager.fromLTRB(20, 35),
        child: getUser(),
      ),
      footer: Container(
      ),
      decoration: BoxDecoration(color: ColorManager.drawer65A30D),
    );
  }
  Widget getUser(){
    return FutureBuilder<UserModel>(
        future: getUserDetail(),
        builder: (context, snapshot){
          String name,image;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
        ),
        child: imageProvider( snapshot.data!.image.toString()),
      ),
          Padding(
            padding: DimensionManager.onlytop(11.8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: DimensionManager.onlyright(20),
                  child: Text(
                      snapshot.data!.name.toString(),
                      style: StyleManager.textweight600size20white()),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(MyApp.navigatorKey.currentContext!,
                        MaterialPageRoute(
                            builder: (context) => const EditProfile()));
                  },
                  child: const ImageIcon(
                    AssetImage("assets/icons/edit.png"),
                    color: Colors.white,
                    size: 24,
                  ),
                )
              ],
            ),
          ),
        ],
      );
    });
  }
  Future<UserModel> getUserDetail() async
  {
    //List<String> userDetail=[];
    UserModel userModel=UserModel();
    var prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString("username");
    String? image=  prefs.getString("profileImage");
    try {
      userModel.nameSet=username!;
      userModel.imageSet=image!;
      String? name=userModel.image==null?"":userModel.image;
      logInfo(name!);
      if(userModel.image==null){
        userModel.imageSet="";
      }
      name=userModel.image==null?"":userModel.image;
      logInfo(name!);

    }
    catch(e){

    }
    logWarning(userModel.toJson().toString());
    return userModel;
  }
  updateCheck(){
    SharedPreferences.getInstance().asStream().listen((event) {
      setState(() {
      });
    });
  }
  Widget imageProvider(String imageUrl) {
    if (imageUrl.length < 10 || imageUrl.isEmpty) {
      return Image.asset(
        "assets/images/Avatarrectangle.png",
        fit: BoxFit.cover,
        height: DimensionManager.divH(100),
        width: DimensionManager.divW(100),
      );
    } else
      return CachedNetworkImage(
        imageUrl:imageUrl,
        imageBuilder: (context, imageProvider) => Container(
          width: 100.0,
          height: 100.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.fill,
            ),


          ),
        ),
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: Colors.white70,
          highlightColor: ColorManager.colorA1A1AA,
          direction: ShimmerDirection.ltr,
          child: const Card(
            color: Colors.grey,
          ),
        ),
        errorWidget: (context, url, error) => Image.asset("assets/images/Avatarrectangle.png",height: 100,width: 100,),
        width: 100,
        height: 100,
        fit: BoxFit.fill,
      );
  }
}

/*
BottomNavyBar(
      selectedIndex: _currentIndex,
      backgroundColor:ColorManager.green84CC16,
      onItemSelected: (index) {
        setState(() => _currentIndex = index);
        _pageController.jumpToPage(index);
      },
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          textAlign:TextAlign.center,
            activeColor:ColorManager.drawer65A30D,
            inactiveColor: ColorManager.drawer65A30D,
            title: Text('Activities',style: StyleManager.textWeight500Size14Color(ColorManager.colorECFCCB),),
            icon: ImageIcon(AssetImage("assets/icons/file-text.png",),size: 24,color: ColorManager.colorECFCCB,)
        ),
        BottomNavyBarItem(
            activeColor:ColorManager.drawer65A30D,
            inactiveColor: ColorManager.drawer65A30D,
            title: Text('Fitness',style: StyleManager.textWeight500Size14Color(ColorManager.colorECFCCB),),
            icon: ImageIcon(AssetImage("assets/icons/heart.png",),size: 24,color: ColorManager.colorECFCCB,)
        ),
        BottomNavyBarItem(
            activeColor:ColorManager.drawer65A30D,
            inactiveColor: ColorManager.drawer65A30D,
            title: Text('Backpack',style: StyleManager.textWeight500Size14Color(ColorManager.colorECFCCB),),
            icon:  ImageIcon(AssetImage("assets/icons/briefcase.png",),size: 24,color: ColorManager.colorECFCCB,)
        ),
        BottomNavyBarItem(
            activeColor:ColorManager.drawer65A30D,
            inactiveColor: ColorManager.drawer65A30D,
            title: Text('Teammates',style: StyleManager.textWeight500Size14Color(ColorManager.colorECFCCB),),
            icon:  ImageIcon(AssetImage("assets/icons/people.png",),size: 24,color: ColorManager.colorECFCCB,)
        ),
      ],
    );
 */
