

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:localstore/localstore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task2/FirebaseCollectionController/storage_service.dart';
import 'package:task2/Model/ActivityModel.dart';
import 'package:task2/Model/BagItemModel.dart';
import 'package:task2/Model/FeedbackModel.dart';
import 'package:task2/Model/LocationModel.dart';
import 'package:task2/Model/UserModel.dart';

import 'package:task2/Model/sign_up_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task2/Model/trip_model.dart';
import 'package:task2/Utilities/color_print_logs.dart';
import 'package:task2/main.dart';
import 'package:task2/screen/mainmenu.dart';

import '../Model/TipsAndTricksModel.dart';

class FireStoreReadWrite {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  String id = FirebaseAuth.instance.currentUser!.uid.toString();

  Future<void> userDataWrite(SignupModel signupModel) {
    return users.doc(id).set(signupModel.toJson()).then((value) async {
      var prefs = await SharedPreferences.getInstance();
      prefs.setString("profileImage", "no image");
      prefs.setString("username", signupModel.name.toString());
      logSuccess("Local Write Successfully");
      ScaffoldMessenger.of(MyApp.navigatorKey.currentContext!)
          .showSnackBar(SnackBar(content: Text("User created successfully")));
    });
  }

  Future<void> addNewTripWrite(TripModel tripModel) async {
    var tripInstance = users.doc(id).collection("trips").doc();
    return tripInstance.set(tripModel.toJson()).then((value) {
      final localInstance = Localstore.instance.collection('trips');
      tripModel.idSet = tripInstance.id;
      localInstance
          .doc(id)
          .set(tripModel.toJson())
          .then((value) => logSuccess("Write Successfully"));
    }).onError((error, stackTrace) {
      logError(error.toString());
    });
  }

  Future<void> feedbackWrite(FeedbackModel feedbackModel) {
    var feedbackInstance = users.doc(id).collection("feedback").doc();
    return feedbackInstance.set(feedbackModel.toJson()).then((value) {
      logSuccess("Write Feedback Sudccesfully");
      ScaffoldMessenger.of(MyApp.navigatorKey.currentContext!).showSnackBar(
          SnackBar(content: Text("Feedback created successfully")));
    }).onError((error, stackTrace) {
      logError(error.toString());
    });
  }

  Future<void> bagPrepareWrite(List<BagItemModel> bagItemUpload) {
    return Localstore.instance
        .collection("trips")
        .doc(id)
        .get()
        .then((value) async {
      TripModel tripModel = await TripModel.fromJson(value);
      logInfo(tripModel.toJson().toString());
      var itemUpload = users
          .doc(id)
          .collection("trips")
          .doc(tripModel.id.toString())
          .collection("bagItems");
      var db = FirebaseFirestore.instance;
      var batch = db.batch();
      bagItemUpload.forEach(((element) {
        BagItemModel item = element;
        logWarning(item.toJson().toString());
        batch.set(itemUpload.doc(), item.toJson());
      }));
      batch.commit().then((value) {
        ScaffoldMessenger.of(MyApp.navigatorKey.currentContext!)
            .showSnackBar(SnackBar(content: Text("Trip created successfully")));
      }).onError((error, stackTrace) {
        logError(error.toString());
      });
    });
  }

  Future<void> activitiesWrite(ActivityModel activityModel) async {
    var snapshot = await users.doc(id).get();
    UserModel user = await UserModel.fromJson(snapshot.data());
    activityModel.authorSet = user.name!;
    return users
        .doc(id)
        .collection("activities")
        .add(activityModel.toJson())
        .then((value) {
      logSuccess("ActivitiesWrite Successfully");
      ScaffoldMessenger.of(MyApp.navigatorKey.currentContext!).showSnackBar(
          SnackBar(content: Text("Activity created successfully")));
      Navigator.pushReplacement(
          MyApp.navigatorKey.currentContext!,
          MaterialPageRoute(
            builder: (context) => MainMenu(),
          ));
    }).onError((error, stackTrace) {
      logError(error.toString());
    });
  }

  Future<String> readTripId() async {
    TripModel tripModel = TripModel();
    await Localstore.instance.collection("trips").doc(id).get().then((value) {
      tripModel = TripModel.fromJson(value);
    });
    return tripModel.id!;
  }

  Future<void> updateUserDetail(UserModel userModel) {
    return users.doc(id).update(userModel.toJson()).then((value) async {
      var prefs = await SharedPreferences.getInstance();
      prefs.setString("profileImage", userModel.image.toString());
      prefs.setString("username", userModel.name.toString());
      logSuccess("Local Write Successfully");
      ScaffoldMessenger.of(MyApp.navigatorKey.currentContext!).showSnackBar(
          SnackBar(content: Text("User details updated successfully")));
      Navigator.pushReplacement(
          MyApp.navigatorKey.currentContext!,
          MaterialPageRoute(
            builder: (context) => MainMenu(),
          ));
    });
  }

  tipsAndTricksWrite(List<TipsAndTricksModel> tripsAndTricksModel) {
    logWarning("tipsAndTricksWrite");
    tripsAndTricksModel.forEach(((element) async {
      TipsAndTricksModel item = element;
      await StorageService().downloadadminUrl(element.imageUrl!).then((value) {
        logInfo("Download Url ${value}");
        item.imageUrlSet = value;
      });
      logWarning(item.toJson().toString());
      await FirebaseFirestore.instance
          .collection("admin")
          .doc("4w1CUwPhki04mINaTotJ")
          .collection("TipsAndTricks")
          .add(item.toJson())
          .then((value) {
        logSuccess(item.toJson().toString());
      }).onError((error, stackTrace) {
        logError(error.toString());
      });
    }));
  }
  locationWrite(List<LocationModel> locationModel) {
    logWarning("locationWrite");
    locationModel.forEach(((element) async {
      LocationModel item = element;
      await StorageService().downloadLocationUrl(element.image!).then((value) {
        logInfo("Download Url ${value}");
        item.imageSet = value;
      });
      logWarning(item.toJson().toString());
      await FirebaseFirestore.instance
          .collection("admin")
          .doc("4w1CUwPhki04mINaTotJ")
          .collection("Locations")
          .add(item.toJson())
          .then((value) {
        logSuccess(item.toJson().toString());
      }).onError((error, stackTrace) {
        logError(error.toString());
      });
    }));
  }
}

/**
    Future<List<BagItemModel>> readBagPackData() async {
    TripModel tripModel=TripModel();
    await Localstore.instance.collection("trips").doc(id).get().then((value) {
    tripModel=TripModel.fromJson(value);
    });
    List<BagItemModel> bagItemModel=[];
    users.doc(id).collection("trips").doc(tripModel.id.toString()).collection("bagItems").get().then((querySnapshot){
    //logInfo(querySnapshot.docs.first.data().toString());
    querySnapshot.docs.forEach((element) {
    bagItemModel.add(BagItemModel.fromJson(element.data()));
    });
    // var list=querySnapshot.docs.map((item)=>BagItemModel.fromJson(item)).toList();
    // bagItemModel=list;
    });
    logSuccess(bagItemModel.single.toJson().toString());
    return bagItemModel;
    }
 */
