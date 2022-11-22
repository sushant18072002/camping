import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:task2/CustumWidget/appbarutilies.dart';
import 'package:task2/CustumWidget/button_ui.dart';
import 'package:task2/CustumWidget/textfield_ui.dart';
import 'package:task2/FirebaseCollectionController/firestore_read_write.dart';
import 'package:task2/Model/trip_model.dart';
import 'package:task2/Utilities/color_manager.dart';
import 'package:task2/Utilities/color_print_logs.dart';
import 'package:task2/Utilities/dimension_manager.dart';
import 'package:task2/Utilities/style_manager.dart';
import 'package:task2/main.dart';
import 'package:task2/screen/add_teammates.dart';
import 'package:task2/screen/location_screen.dart';
import 'package:task2/screen/prepare_your_bag.dart';
import 'package:intl/intl.dart';
TripModel tripModel = TripModel();
class AddTripForm extends StatefulWidget {
  @override
  State<AddTripForm> createState() => _AddTripFormState();
}

class _AddTripFormState extends State<AddTripForm> {
  final dateController = DateRangePickerController();
  TextEditingController dateTextFieldController = TextEditingController();
  TextEditingController tripNameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  bool flag=false;

  String _range = '';

  @override
  void initState() {
    super.initState();
    if (tripModel.location != null)
      locationController.text = tripModel.location.toString();
    if (tripModel.tripName != null)
      tripNameController.text = tripModel.tripName.toString();
  }

  @override
  void dispose() {
    super.dispose();
    dateController.dispose();
    dateTextFieldController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: ColorManager.white,
        appBar: AppBarUtilies.appbarUtil("Add New Trip"),
        body: bodyUi(context));
  }

  Widget bodyUi(context) {
    return Stack(
      children: [
        Padding(
          padding: DimensionManager.fromLTRB(20, 29, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFieldUi.LabelTextField(
                  "Trip Name", false, 0, "", tripNameController),
              TextFieldUi.LabelTextField(
                  "Location", false, 20.0, "", locationController),
              Container(
                margin: DimensionManager.fromLTRB(0, 16, 0, 20),
                width: DimensionManager.divW(134),
                child: ButtonUi.outlineButtonWithFunction(
                    ViewLocationNavigate, "View Locations", 45),
              ),
              TextFieldUi.LabelText("Teammates"),
              newTeammates(),
              Container(
                margin: DimensionManager.fromLTRB(0, 16, 0, 20),
                width: DimensionManager.divW(174),
                child: ButtonUi.outlineButtonWithFunction(
                    navigationToAddTeammates, "Add New Teammates", 45),
              ),
              dateShowField(),
              Padding(
                padding: DimensionManager.onlytop(24),
                child: ButtonUi.filledbuttonCustumWithFunction(
                    writeDataValidation, "Start"),
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

  Widget newTeammates() {
    if (tripModel.teammates == null) {
      return Container(
          margin: DimensionManager.fromLTRB(0, 8, 0, 16),
          height: DimensionManager.divH(80),
          width: DimensionManager.divW(80),
          child: Container(
            padding: EdgeInsets.all(1.5),
            decoration: BoxDecoration(
              color: ColorManager.colorF4F4F5,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddTeammates(tripModel: tripModel,)));
              },
              style: ElevatedButton.styleFrom(
                  primary: ColorManager.colorFAFAFA,
                  elevation: 0,
                  minimumSize: Size.fromHeight(DimensionManager.divH(44)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  )
                  //fixedSize: Size(double.infinity, height/18.75)
                  ),
              child: Center(
                child: Image.asset(
                  "assets/icons/plus.png",
                  width: 32,
                  height: 32,
                ),
              ),
            ),
          ));
    }
    return Container(
      margin: DimensionManager.onlytop(8),
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemCount: tripModel.teammates!.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: DimensionManager.onlyright(15),
            child: Image.asset(
              "assets/images/Avatarrectangle.png",
              height: 80,
              width: 80,
            ),
          );
        },
      ),
    );
  }

  Widget dateShowField() {
    return StatefulBuilder(
      builder: (context, setState) {
        return Container(
          height: DimensionManager.divH(48.0),
          child: TextFormField(
            controller: dateTextFieldController,
            showCursor: true,
            readOnly: true,
            onTap: () {
              dataPicker(context, dateController);
            },
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: ColorManager.color3F3F46),
            decoration: InputDecoration(
              suffixIcon: const ImageIcon(
                AssetImage("assets/images/chevron-down.png"),
                size: 10,
              ),
              suffixIconConstraints:
                  BoxConstraints(minHeight: 24, minWidth: 40),
              filled: true,
              hintText: "Pick Date",
              contentPadding: EdgeInsets.fromLTRB(16.0, 12.0, 0.0, 12.0),
              hintStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: ColorManager.colorA1A1AA,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        );
      },
    );
  }

  dataPicker(context, myController) {
    return showDialog<Widget>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 380,
            width: 343,
            clipBehavior: Clip.hardEdge,
            margin: DimensionManager.fromLTRB(16, 182, 16, 250),
            padding: DimensionManager.fromLTRB(8, 8, 8, 8),
            decoration: BoxDecoration(
              color: ColorManager.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: SfDateRangePicker(
              controller: myController,
              toggleDaySelection: false,
              headerStyle: DateRangePickerHeaderStyle(
                  textStyle: StyleManager.textweight600size20black()),
              onSelectionChanged:
                  _onSelectionChanged /*(dateRangePickerSelectionChangedArgs) {
                setState(() {
                  dateTextFieldController.text=dateRangePickerSelectionChangedArgs.value.toString();
                });
                logInfo(dateRangePickerSelectionChangedArgs.value.toString());
              }*/
              ,
              todayHighlightColor: ColorManager.bellGround,
              startRangeSelectionColor: ColorManager.bellGround,
              endRangeSelectionColor: ColorManager.bellGround,
              rangeSelectionColor: ColorManager.f7FEE7,
              selectionMode: DateRangePickerSelectionMode.range,
              monthCellStyle: DateRangePickerMonthCellStyle(
                  textStyle: StyleManager.textweight400size20black()),
              rangeTextStyle: StyleManager.textweight400size20black(),
              selectionTextStyle: StyleManager.textweight400size20white(),
              onSubmit: (value) {
                logSuccess(value.toString());
                setState(() {
                  dateTextFieldController.text = value.toString();
                });
                Navigator.pop(context);
              },
              onCancel: () {
                logWarning("Cancel.........");
                Navigator.pop(context);
              },
            ),
          );
        });
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        _range = '${DateFormat('d MMMM y').format(args.value.startDate)} -'
            ' ${DateFormat('d MMMM y').format(args.value.endDate ?? args.value.startDate)}';
        setState(() {
          dateTextFieldController.text = _range;
          tripModel.pickDateSet = _range;
        });
      }
    });
  }

  writeDataValidation() async {
    if (tripNameController.text == null ||
        locationController.text == null ||
        tripModel.teammates == null ||
        dateTextFieldController.text == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Please fill all feild")));
    } else {
      setState(() {
        flag=true;
      });
      BuildContext context = MyApp.navigatorKey.currentContext!;
      logSuccess(tripModel.toJson().toString());
      await FireStoreReadWrite()
          .addNewTripWrite(tripModel)
          .then((value) {
       tripModel=TripModel();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => PrePareYourBag(),
              ));
          });
      setState(() {
        flag==flag;
      });
    }
  }

  ViewLocationNavigate() {
    tripModel.tripNameSet = tripNameController.text;
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LocationScreen(),
        ));
  }
  navigationToAddTeammates(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => AddTeammates(tripModel: tripModel),));
  }
}

