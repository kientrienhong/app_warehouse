import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {
  static UploadTask uploadFile(String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);
      return ref.putFile(file);
    } on FirebaseException catch (e) {
      return null;
    }
  }

  static Future<String> firebaseLogin(String email, String password) async {
    final auth = FirebaseAuth.instance;
    UserCredential userCredential;
    try {
      userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return await userCredential.user.getIdToken();
    } catch (e) {
      return null;
    }
  }
}
