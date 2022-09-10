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

  String uidUser() {
    return auth.currentUser!.uid;
  }

  Future<bool> signInWithEmail(
      {required BuildContext context,
      required String email,
      required Uint8List? image,
      required String name,
      required String pass,
      required ValueChanged userDataClass,
      required String phoneNumber}) async {
    try {
      await auth.createUserWithEmailAndPassword(email: email, password: pass);

      // await sendAuthEmial();
      String? imageUrl = null;
      if (image != null) {
        imageUrl = await StorgeImageFireBase().addImageItem(image: image);
      }
      user.User _user = user.User(
        name: name,
        email: email,
        phoneNumber: phoneNumber,
        imageUrl: imageUrl,
        unversitys: [],
      );
      await StoreAndLoadDataFirebase().store(
          collection: 'Users',
          doc: auth.currentUser!.uid,
          data: _user.toJson());
      userDataClass(_user);

      return true;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
      Navigator.pop(context);
      await Dialoges().showErrorDialog(
          context: context, errorMassage: e.message ?? e.toString());
      return false;
    }
  }

  Future<bool> loginUsingEmail(
      {required BuildContext context,
      required String email,
      required ValueChanged userDataClass,
      required String pass}) async {
    try {
      UserCredential userSingIn =
          await auth.signInWithEmailAndPassword(email: email, password: pass);
      if (userSingIn.user == null) {
        throw 'Email or password not correct';
      }
      Map<String, dynamic>? userData = await StoreAndLoadDataFirebase()
          .load(collection: 'Users', doc: auth.currentUser!.uid);
      user.User userLogin = user.User.fromJson(userData!);

      userDataClass(userLogin);

      return true;
    } on FirebaseAuthException catch (e) {
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
