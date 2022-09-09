import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
}
