import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthuntication {
  FirebaseAuth auth = FirebaseAuth.instance;
  Future<bool> signInWithEmail(
      {required BuildContext context, required String email}) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: '198Mohammed#');
      return true;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
