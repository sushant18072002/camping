import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:task2/Utilities/color_print_logs.dart';

class StorageService{
  final FirebaseStorage storage=FirebaseStorage.instance;
  String id=FirebaseAuth.instance.currentUser!.uid;
  Future<void> uploadFiles(String filePath,String fileName) async{
    File file=File(filePath);
    try{
      await storage.ref('users/${id}/Catchsnaps/$fileName').putFile(file);
    } on FirebaseException catch(e){
      logError("???????????????????????????");
      logError(e.message.toString());
    }
  }
  Future<ListResult> ListFiles() async {
    ListResult result = await storage.ref('users/${id}/Catchsnaps').listAll();
    result.items.forEach((Reference ref) {
      print("found file: $ref");
    });
    return result;
  }
  Future<String> downloadUrl(String imageName) async{
    String downloadUrl=await storage.ref('users/${id}/Catchsnaps/${imageName}').getDownloadURL();
    return downloadUrl;
  }
  Future<void> uploadproFileImage(String filePath,String fileName) async{
    //File file=File(filePath);
    logWarning("Click");
    File file=File(filePath);
    try{
      await storage.ref('users/${id}/profileImage').putFile(file);
    } on FirebaseException catch(e){
      logError("???????????????????????????");
      logError(e.message.toString());
    }

  }
  Future<String> downloadprofileUrl() async{
    String downloadUrl=await storage.ref('users/${id}/profileImage').getDownloadURL();
    return downloadUrl;
  }
  Future<ListResult> adminListFiles() async {
    ListResult result = await storage.ref('admin/TipsAndTricks').listAll();
    result.items.forEach((Reference ref) {
      print("found file: $ref");
    });
    return result;
  }
  Future<String> downloadadminUrl(String imageName) async{
    String downloadUrl=await storage.ref('admin/TipsAndTricks/${imageName}').getDownloadURL();
    return downloadUrl;
  }
  Future<String> downloadLocationUrl(String imageName) async{
    String downloadUrl=await storage.ref('admin/locations/${imageName}').getDownloadURL().onError((error, stackTrace) {
      logError(error.toString());
      return Future<String>(() => "");
    });
    return downloadUrl;
  }
}