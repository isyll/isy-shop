import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  final _firebaseAuth = FirebaseAuth.instance;

  Future<User?> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      log('   --->> error occured signup $e');
    }
    return null;
  }

  Future<User?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      log('   --->> error occured signin $e');
    }
    return null;
  }

  User? get currentUser => _firebaseAuth.currentUser;

  bool get isLoggedIn => currentUser != null;
}
