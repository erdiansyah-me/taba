import 'dart:io';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseServices {
  get storage => null;
  get photoURL => null;


  static Future<String> uploadImage(File imageFile) async {
    String fileName = basename(imageFile.path);

    Reference ref = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = ref.putFile(imageFile);
    TaskSnapshot snapshot = (await uploadTask);

    return await snapshot.ref.getDownloadURL();
  }
  Future<String> downloadURL(String imageName) async {
    String downloadURL = await storage.ref('test/$photoURL').getDownloadURL();

    return downloadURL;
  }
}