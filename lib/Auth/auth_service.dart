import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loop_lab/Auth/login.dart';
import 'package:loop_lab/Shared/shared_resource.dart';
import 'package:loop_lab/bottom_navbar.dart';

Future<void> signUpUser(
  String email,
  String password,
  String fullName,
  String phoneNumber,
  BuildContext context,
) async {
  try {
    // Create account
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    // Get user ID
    String uid = userCredential.user!.uid;

    // Save extra data to Firestore
    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'uid': uid,
      'email': email,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'role': "student",
      'createdAt': DateTime.now(),
    });

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SigninScreen()),
    );
  } on FirebaseAuthException catch (e) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(e.message ?? "Sign-up failed")));
  }
}

Future<void> loginUser(
  String email,
  String password,
  BuildContext context,
) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    String uid = userCredential.user!.uid;
    await fetchUserData(uid);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => BottomNavBar()),
    );
  } on FirebaseAuthException catch (e) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(e.message ?? "Login failed")));
  }
}

Future<bool> isUserLoggedInAsync() async {
  final user = FirebaseAuth.instance.currentUser;
  return user != null;
}
