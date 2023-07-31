import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

User? currUser = FirebaseAuth.instance.currentUser;

signupUser(BuildContext context, String email, String password,
    String username) async {
  try {
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    Navigator.pop(context);
    await FirebaseAuth.instance.currentUser!.updateDisplayName(username);
    await FirebaseAuth.instance.currentUser!.updateEmail(email);
    saveUserData(email, username);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print("The password is too weak.");
    } else {
      print('The account already exists');
    }
  } catch (e) {
    print(e);
  }
}

loginUser(BuildContext context, String email, String password) async {
  try {
    final credential = FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    Navigator.pop(context);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email');
    } else if (e.code == 'wrong-password') {
      print('wrong password provided for that user.');
    }
  }
}

saveUserData(String email, String username) async {
  await FirebaseFirestore.instance.collection('Users').doc(currUser!.uid).set({
    'uid': currUser!.uid,
    'email': email,
    'username': username,
  });
}
