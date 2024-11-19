import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prototype/view/authentication/login.dart';

class LogOut {
  static Future<Widget?> showLogOutDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          content: const Text(
            'Are you sure you want to log out ?',
            style: TextStyle(fontWeight: FontWeight.w400),
          ),
          // titlePadding:  EdgeInsets.only(top: 30, left: 30, right: 30),
          contentPadding: const EdgeInsets.only(top: 30, left: 30, right: 30),
          backgroundColor: Colors.grey.shade400,

          elevation: 10,
          // shadowColor: Colors.grey.shade500,

          actionsPadding:
              const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          actions: [
            TextButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>Login(login: true)));
                },
                child: Text(
                  "Yes",
                  style: TextStyle(color: Colors.grey.shade800),
                )),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "No",
                  style: TextStyle(color: Colors.grey.shade800),
                ))
          ],
        );
      },
    );
  }
}
