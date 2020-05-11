import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class BaseAuth {
  Stream<String> get onAuthStateChanged;

  Future<String> signInWithEmailAndPassword(
      String email,
      String password,
);

  Future<String> createInWithEmailAndPassword(
      String email, String password,
      );


}