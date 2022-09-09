import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_company/controller/dataBase/store_data.dart';
import 'package:task_company/controller/dataBase/storge_image.dart';

import 'package:task_company/model/user.dart' as user;
import 'package:task_company/view/pages/check_email_validation.dart';
import 'package:task_company/view/widget/dialog.dart';

class FirebaseAuthuntication {
  FirebaseAuth auth = FirebaseAuth.instance;
  bool isActivedUser() {
    return auth.currentUser!.emailVerified;
  }

  Future<bool> signInWithEmail(
      {required BuildContext context,
      required String email,
      required Uint8List? image,
      required String name,
      required String phoneNumber}) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: '198Mohammed#');

      // await sendAuthEmial();
      String? imageUrl = null;
      if (image != null) {
        imageUrl = await StorgeImageFireBase().addImageItem(image: image);
      }
      user.User _user = user.User(
          name: name,
          email: phoneNumber,
          phoneNumber: email,
          imageUrl: imageUrl);
      await StoreAndLoadDataFirebase().store(
          collection: 'Users',
          doc: auth.currentUser!.uid,
          data: _user.toJson());

      return true;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
      Navigator.pop(context);
      await Dialoges().showErrorDialog(
          context: context, errorMassage: e.message ?? e.toString());
      return false;
    }
  }

  Future<void> sendAuthEmial() async {
    try {
      await auth.currentUser!.sendEmailVerification();
    } catch (e) {
      // debugPrint(e.toString());
    }
  }
}
