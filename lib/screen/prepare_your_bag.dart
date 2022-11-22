import 'package:flutter/material.dart';
import 'package:task2/CustumWidget/appbarutilies.dart';
import 'package:task2/CustumWidget/button_ui.dart';
import 'package:task2/CustumWidget/counter.dart';
import 'package:task2/CustumWidget/custum_check_box.dart';
import 'package:task2/FirebaseCollectionController/firestore_read_write.dart';
import 'package:task2/Model/BagItemModel.dart';
import 'package:task2/Utilities/color_manager.dart';
import 'package:task2/Utilities/color_print_logs.dart';
import 'package:task2/Utilities/dimension_manager.dart';
import 'package:task2/Utilities/image_manager.dart';
import 'package:task2/Utilities/string_manager.dart';
import 'package:task2/Utilities/style_manager.dart';
import 'package:task2/main.dart';
import 'package:task2/screen/Menu.dart';
import 'package:task2/screen/mainmenu.dart';

class PrePareYourBag extends StatefulWidget {

  @override
  State<PrePareYourBag> createState() => _PrePareYourBagState();
}

class _PrePareYourBagState extends State<PrePareYourBag> {
  final myController = TextEditingController();

  List<BagItemModel> bagItems = List.empty();
  bool flag=false;
  void getBagItems() {
    setState(() {
      bagItems =  BagItemModel.getUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    getBagItems();
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBarUtilies.appbarUtil(
          StringManager.prepareYourBag1),
      body: bodyUi(context),
    );
  }

  Widget bodyUi(BuildContext context) {
    return Stack(
      children: [
        Container(
          constraints: BoxConstraints(maxHeight: DimensionManager.height),
          child: Stack(
            children: [
              Container(
                constraints: BoxConstraints(maxHeight: DimensionManager.height),
                padding: DimensionManager.fromLTRB(20, 0, 20),
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                    itemCount: bagItems.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding:index ==bagItems.length-1? const EdgeInsets.only(top: 14.0,bottom: 80):EdgeInsets.only(top: 14.0),
                        child: Row(
                          children: [
                            CustumCheckbox(bagItemModel: bagItems[index]),
                            Container(
                              padding: DimensionManager.onlyleft(16),
                              width: 202,
                              child: Text(
                                bagItems[index].item.toString(),
                                style: StyleManager.textWeight400Size16black(),
                              ),
                            ),
                            Spacer(),
                            Counter(bagItemModel: bagItems[index])
                          ],
                        ),
                      );
                    }),
              ),
              Positioned(
                bottom: 10,
                child: Container(
                  margin: DimensionManager.fromLTRB(40, 0, 40, 19),
                  width: DimensionManager.divW(295),
                  height: 44,
                  child: ButtonUi.filledbuttonCustumWithFunction(
                      bagItemValidation, "Ready"),
                ),
              )
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
            child: const SizedBox(
                height: 100,
                width: 100,
                child: CircularProgressIndicator()),
          ),
        )
      ],
    );
  }

  bagItemValidation() async {
    setState(() {
      flag=true;
    });
    List<BagItemModel> bagItemUpload = [];
    BuildContext context = MyApp.navigatorKey.currentContext!;
    for (var items in bagItems) {
      if (items.isCheck == true) {
        try {
          bagItemUpload.add(items);
        } catch (e) {
          logError(e.toString());
        }
      }
    }
    if(bagItemUpload.isEmpty){
      ScaffoldMessenger.of(MyApp.navigatorKey.currentContext!).showSnackBar(SnackBar(content: Text("Please select an item")));
    }
    else {
      await FireStoreReadWrite().bagPrepareWrite(bagItemUpload).then((value) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MainMenu(),
          ),
        );
      });
    }
    setState(() {
      flag=false;
    });
  }
}
