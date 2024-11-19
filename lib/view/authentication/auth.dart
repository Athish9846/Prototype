 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prototype/components/landing_page.dart';
import 'package:prototype/view/student/data/student_datatable.dart';


class LogAuth {
  String errorMsg = '';
  static Future<bool> checkSignIn({
    required GlobalKey<FormState> formlog,
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    if (formlog.currentState!.validate()) {
      showDialog(
          context: context,
          builder: (context) => const Center(
                child: CircularProgressIndicator(),
              ));
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);

        // Fetch user document from Firestore
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .get();

        // Get user role
        String userRole = userDoc['role'];

        // Navigate based on user role
        if (userRole == 'admin') {
          // Navigate to admin page
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (ctx) => const LandingPage()),
          );
      
        } else {
          // Navigate to student profile
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (ctx) => const StudentDataTable()),
          );
        }
      } on FirebaseAuthException catch (e) {
        String errorMSg;
        if (e.code == 'user-not-found' || e.code == 'wrong=password') {
          errorMSg = 'Email or password not found';
        } else {
          errorMSg = 'An error occured, please try again later';
        }
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text('Error'),
                  content: Text(errorMSg),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: (const Text('OK')))
                  ],
                ));
        return false;
      }
    }
    return false;
  }

  static Future<bool> checkSignUp({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
  }) async {
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    try {
      var user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      FirebaseFirestore firebase = FirebaseFirestore.instance;
      CollectionReference userCollection = firebase.collection('users');
      DocumentReference userdoc = userCollection.doc(user.user!.uid);
      String role = email.contains('admin123@gmail.com') ? 'admin' : 'student';
      Map<String, dynamic> userDetails = {
        'name': name,
        'email': email,
        'role': role,
      };
      await userdoc.set(userDetails);
     
      return true;
    } on FirebaseAuthException catch (e) {
      String errorMsg = e.code;

      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Error'),
                content: Text(errorMsg),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: const Text('OK'))
                ],
              ));
      return false;
    }
  }

  
}
