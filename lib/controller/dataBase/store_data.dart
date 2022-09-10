import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_company/view/widget/dialog.dart';

class StoreAndLoadDataFirebase {
  final FirebaseFirestore fireStroe = FirebaseFirestore.instance;
  Future<bool> store(
      {required String collection,
      required String doc,
      required Map<String, dynamic> data}) async {
    try {
      await fireStroe.collection(collection).doc(doc).set(data);
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<Map<String, dynamic>?> load({
    required String collection,
    required String doc,
  }) async {
    try {
      var data = await fireStroe.collection(collection).doc(doc).get();
      return data.data();
    } catch (e) {
      debugPrint(e.toString());
      throw e.toString();
    }
  }

  Future update({
    required BuildContext context,
    required String collection,
    required String doc,
    required Map<String, dynamic> dataMap,
  }) async {
    try {
      await fireStroe.collection(collection).doc(doc).update(dataMap);
    } on FirebaseException catch (e) {
      Dialoges().showErrorDialog(
          context: context,
          errorMassage: e.message ?? "Some error accours ,please try again");
      debugPrint(e.toString());
      throw e.toString();
    }
  }
}
