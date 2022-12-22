import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
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
      final ref = _storage.ref().child(path);
      uploadTask = ref.putFile(file);

      final snapshot = await uploadTask.whenComplete(() {});

      final urlDownload = await snapshot.ref.getDownloadURL();

      var collection = FirebaseFirestore.instance.collection('users');

      await collection
          .doc(uid)
          .collection('urls')
          .doc(pickerfile.name)
          .get()
          .then((sanphot) => collection
              .doc(uid)
              .collection('urls')
              .doc(pickerfile.name)
              .delete());

      await collection
          .doc(uid)
          .collection('urls')
          .doc(pickerfile.name)
          .set({'url': urlDownload});
      res = 'success';
    } catch (err) {
      return res = err.toString();
    }
    return res;
  }

  Future<void> getFiles(uid) async {
    List<Map<String, dynamic>>? docfiles;
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('urls')
        .get();

    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var a = querySnapshot.docs[i];
      docfiles?.add({'fileName': a.id, 'url': a.get('url')});
    }
  }

  Future<void> deleteFile(uid, fileName) async {
    var collection = FirebaseFirestore.instance.collection('users');

    await collection.doc(uid).collection('urls').doc(fileName).get().then(
        (sanphot) =>
            collection.doc(uid).collection('urls').doc(fileName).delete());

    await FirebaseStorage.instance
        .ref()
        .child('Documents/$uid/$fileName')
        .delete();
  }
}
