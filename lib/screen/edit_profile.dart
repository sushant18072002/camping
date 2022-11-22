import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:task2/CustumWidget/appbarutilies.dart';
import 'package:task2/CustumWidget/button_ui.dart';
import 'package:task2/CustumWidget/textfield_ui.dart';
import 'package:task2/FirebaseCollectionController/firestore_read_write.dart';
import 'package:task2/FirebaseCollectionController/storage_service.dart';
import 'package:task2/Model/UserModel.dart';
import 'package:task2/Model/UserModel.dart';
import 'package:task2/Model/UserModel.dart';
import 'package:task2/Model/UserModel.dart';
import 'package:task2/Model/sign_up_model.dart';
import 'package:task2/Utilities/color_manager.dart';
import 'package:task2/Utilities/color_print_logs.dart';
import 'package:task2/Utilities/dimension_manager.dart';
import 'package:task2/Utilities/style_manager.dart';
import 'package:task2/screen/mainmenu.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  UserModel userModel = UserModel();
  bool flag=false;

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBarUtilies.appbarUtilWithClassNavitor("Edit Profile",MainMenu()),
      body: readData(),
    );
  }

  Widget bodyUi(UserModel userModel) {
    nameController.text = userModel.name.toString();
    descriptionController.text = userModel.description.toString();

    return Stack(
      children: [
        Padding(
          padding: DimensionManager.fromLTRB(20, 10, 20),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //Image.asset("assets/images/Avatarrectangle.png",height: 100,width: 100,),
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      shape: BoxShape.rectangle
                    ),
                    child: CachedNetworkImage(
                      imageUrl: userModel.image.toString(),
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
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  GestureDetector(
                      onTap: () {
                        profileImagePick();
                      },
                      child: Text(
                        "Change Profile",
                        style: StyleManager.textWeight500Size14Color(
                            ColorManager.green84CC16),
                      ))
                ],
              ),
              Padding(
                padding: DimensionManager.topAndBottom(24, 20),
                child: TextFieldUi.LabelTextField(
                    "Name", false, 0.0, "", nameController),
              ),
              Text(
                "Bio",
                style:
                    StyleManager.textWeight400Size16Color(ColorManager.color71717A),
              ),
              Container(
                  padding: DimensionManager.topAndBottom(12, 24),
                  child:
                      //CustumTextField("Researching, designing, implementing, \nand managing software programs.\nTesting and evaluating new programs. \nIdentifying areas for modification in \nexisting programs and subsequently \ndeveloping these modifications. Writing and \nimplementing efficient code."),
                      CustumTextField(descriptionController)),
              ButtonUi.filledbuttonCustumWithFunction(validationDetails, "Save")
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

  Widget CustumTextField(controller) {
    return Container(
      height: DimensionManager.divH(192),
      decoration: BoxDecoration(
        color: ColorManager.colorFAFAFA,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        style: StyleManager.textWeight400Size16Color(ColorManager.color3F3F46),
        textAlign: TextAlign.justify,
        keyboardType: TextInputType.multiline,
        controller: controller,
        maxLines: null,
        decoration: InputDecoration(
          //hintText: hint,
          contentPadding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 12.0),
          //hintStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: ColorManager.colorA1A1AA,),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget readData() {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    String id = FirebaseAuth.instance.currentUser!.uid.toString();
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(id).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          //Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          userModel = UserModel.fromJson(snapshot.data!.data());
          return bodyUi(userModel);
        }

        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: DimensionManager.height,
          child: Shimmer.fromColors(
            child: Card(
              color: Colors.grey,
            ),
            baseColor: Colors.white70,
            highlightColor: ColorManager.colorA1A1AA,
            direction: ShimmerDirection.ltr,
          ),
        );
      },
    );
  }

  validationDetails() async{
    userModel.nameSet = nameController.text;
    userModel.descriptionSet = descriptionController.text;
    setState(() {
      flag=true;
    });
    await FireStoreReadWrite().updateUserDetail(userModel).then((value) {
      final snackBar = SnackBar(content: Text('Successfully Updated'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      setState(() {
      });
    });
    setState(() {
      flag=false;
    });
  }

  profileImagePick() async {
    final results = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (results == null) {
      Scaffold.of(context)
          .showSnackBar(const SnackBar(content: Text('no fill is selected')));
      return null;
    }
    final filePath = results.files.single.path!;
    final fileName = results.files.single.name;
    setState(() {
      flag=true;
    });
    await StorageService()
        .uploadproFileImage(filePath,fileName)
        .then((value){
       logSuccess("uploadSuccessfully");
      StorageService().downloadprofileUrl().then((value) {
        logSuccess("downloadprofileUrl ${value}");
        userModel.imageSet=value;
        logError(userModel.toJson().toString());
        FireStoreReadWrite().updateUserDetail(userModel);
      });
    });
    setState(() {
      flag=false;
    });
  }
}
