import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  Reference _storageReference;
  @override
  Future<String> uploadFile(String userID, File yuklenecekDosya) async {
    _storageReference = _firebaseStorage
        .ref()
        .child(userID)
        .child("profil_photo")
        .child("profil_photo");
    var _uploadTask = _storageReference.putFile(yuklenecekDosya);
    var url =
        await (await _uploadTask.whenComplete(() {})).ref.getDownloadURL();
    return url;
  }

  Future uploadVideo({file}) async {
    var randomID = FirebaseFirestore.instance.collection("teachers").doc().id;
    Reference ref = FirebaseStorage.instance.ref(randomID).child("videos");
    UploadTask uploadTask = ref.putFile(File(file.path));
    var url = (await (await uploadTask).ref.getDownloadURL());
    return url;
  }
}
