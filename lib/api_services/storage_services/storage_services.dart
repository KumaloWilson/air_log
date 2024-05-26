import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class StorageServices{

  static final FirebaseStorage _storage = FirebaseStorage.instance;

  static Future<String?> uploadUsedDp({required File file, required String uid}) async{
    Reference fileRef = _storage.ref('users/dps').child('$uid${extension(file.path)}');
  
    UploadTask task = fileRef.putFile(file);

    return task.then((p){
      if(p.state == TaskState.success){
        return fileRef.getDownloadURL();
      }
      return null;
    });
  }

  static Future<String?> uploadImageToChat({required File file, required String chatID}) async{
    Reference fileRef = _storage.ref('chats/$chatID').child('${DateTime.now().toIso8601String()}${extension(file.path)}');

    UploadTask task = fileRef.putFile(file);

    return task.then((p){
      if(p.state == TaskState.success){
        return fileRef.getDownloadURL();
      }
      return null;
    });
  }

  static Future<List<String?>> uploadProductImages({required List<File> files}) async {
    List<String?> downloadURLs = [];

    for (File file in files) {
      String fileName = file.path.split('/').last;
      Reference fileRef = _storage.ref('products/$fileName').child('${DateTime.now().toIso8601String()}${extension(file.path)}');
      UploadTask task = fileRef.putFile(file);

      String? downloadURL = await task.then((snapshot) async {
        if (snapshot.state == TaskState.success) {
          return await fileRef.getDownloadURL();
        }
        return null;
      });

      downloadURLs.add(downloadURL);
    }

    return downloadURLs;
  }

}