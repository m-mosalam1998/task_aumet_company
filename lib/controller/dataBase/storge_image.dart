import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class StorgeImageFireBase {
  Future<String?> addImageItem({
    required Uint8List image,
  }) async {
    try {
      Reference _ref = FirebaseStorage.instance
          .ref()
          .child(FirebaseAuth.instance.currentUser!.uid);

      UploadTask uploadTask = _ref.putData(image);
      TaskSnapshot _task = await uploadTask;
      String photoUrl = await _task.ref.getDownloadURL();
      return photoUrl;
    } catch (e) {
      debugPrint("storge : ${e.toString()}");
      return null;
    }
  }
}
