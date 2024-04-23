import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Future<UserCredential?> loginWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();

      final googleAuth = await googleUser?.authentication;

      final cred = GoogleAuthProvider.credential(
          idToken: googleAuth?.idToken, accessToken: googleAuth?.accessToken);

      final userCredential = await _auth.signInWithCredential(cred);
      Fluttertoast.showToast(
          msg: "Inicio de sesión exitoso",
          backgroundColor: Colors.green);
      return userCredential;
    } catch (e) {
      Fluttertoast.showToast(
          msg: e.toString(), backgroundColor: Colors.red);
    }
    return null;
  }

  Future<User?> createUserWithEmailAndPassword(
      String user, String password) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
          email: user, password: password);
      return cred.user;
    } catch (e) {
      handleError(e);
    }
    return null;
  }

  Future<User?> loginUserWithEmailAndPassword(
      String user, String password) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
          email: user, password: password);
      Fluttertoast.showToast(
          msg: "Inicio de sesión exitoso",
          backgroundColor: Colors.green);
      return cred.user;
    } on FirebaseAuthException catch (e) {
      handleError(e);
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Algo salió mal", backgroundColor: Colors.red);
    }
    return null;
  }

  Future<void> signout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Algo salió mal", backgroundColor: Colors.red);
    }
  }

  void handleError(dynamic e) {
    if (e is FirebaseAuthException) {
      switch (e.code) {
        case "invalid-credentials":
          Fluttertoast.showToast(
              msg: "Tus credenciales de inicio de sesión no son válidas",
              backgroundColor: Colors.red);
          break;
        case "weak-password":
          Fluttertoast.showToast(
              msg: "Tu contraseña debe tener más de 8 caracteres",
              backgroundColor: Colors.red);
          break;
        case "email-already-in-use":
          Fluttertoast.showToast(
              msg: "El email ya existe", backgroundColor: Colors.red);
          break;
        default:
          Fluttertoast.showToast(
              msg: "Algo salió mal", backgroundColor: Colors.red);
      }
    } else {
      Fluttertoast.showToast(
          msg: "Algo salió mal", backgroundColor: Colors.red);
    }
  }
}
