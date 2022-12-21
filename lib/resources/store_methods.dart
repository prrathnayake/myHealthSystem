import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';

class StoreMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadFile(
      {required String uid, required PlatformFile pickerfile}) async {
    String res = "Some Error Occurred";
    UploadTask? uploadTask;

    try {
      final path = 'Documents/$uid/${pickerfile.name}';
      final file = File(pickerfile.path!);
      final ref = FirebaseStorage.instance.ref().child(path);
      uploadTask = ref.putFile(file);

      final snapshot = await uploadTask.whenComplete(() {});

      final urlDownload = await snapshot.ref.getDownloadURL();
      print(urlDownload);
      res = 'success';
    } catch (err) {
      return res = err.toString();
    }
    return res;
  }
}
