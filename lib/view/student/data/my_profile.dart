
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prototype/components/app_bar.dart';
import 'package:prototype/components/mytextbox.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final currentUser = FirebaseAuth.instance.currentUser!;

  // edit field
  Future<void> editField(String field) async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kTextTabBarHeight),
            child: MyAppBar(
              appbartitle: '',
              automaticallyImplyLeading: true,
              iconThemeData: const IconThemeData(color: Colors.white),
            )),
        body: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(currentUser.email!)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot != null) {
                final userData = snapshot.data!.data() as Map<String, dynamic>;
                print(snapshot.data!.data());
                return SafeArea(
                    child: Column(
                  children: [
                    ListView(
                      children: [
                        const SizedBox(
                          height: 50,
                        ),

                        // profile pic
                        const Icon(
                          Icons.person,
                          size: 72,
                        ),

                        // user email
                        Text(
                          currentUser.email!,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey[700]),
                        ),

                        const SizedBox(
                          height: 50,
                        ),

                        // user details
                        Padding(
                          padding: const EdgeInsets.only(left: 25.0),
                          child: Text(
                            'My Details',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                        ),

                        // username
                        MyTextBox(
                            text: userData['username'],
                            sectionName: 'username',
                            onPressed: () => editField('username')),

                        // bio
                        MyTextBox(
                            text: userData['bio'],
                            sectionName: 'bio',
                            onPressed: () => editField('bio')),

                        // user posts
                      ],
                    )
                  ],
                ));
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error${snapshot.error}'),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}
