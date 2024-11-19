import 'dart:io';
import 'package:flutter/material.dart';
import 'package:prototype/components/app_bar.dart';
import 'package:prototype/models/admin_model.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class StudentProfile extends StatelessWidget {
  final BatchModel studentData;
   StudentProfile({super.key, required this.studentData});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kTextTabBarHeight),
          child: MyAppBar(
            appbartitle: 'STUDENT PROFILE',
            automaticallyImplyLeading: true,
            iconThemeData: const IconThemeData(color: Colors.white),
          )),
      //  AppBar(
      //   title: const Text('MY PROFILE'),
      //   centerTitle: true,
      // ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Student\nDashboard',
                          style: TextStyle(
                              letterSpacing: 3,
                              fontSize: 30,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        StepProgressIndicator(
                          totalSteps: 100,
                          currentStep: 32,
                          size: 8,
                          padding: 0,
                          selectedColor: Colors.yellow,
                          // selectedSize: 10,
                          // unselectedSize: 10,
                          unselectedColor: Colors.cyan,
                          roundedEdges: Radius.circular(10),
                          selectedGradientColor: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Colors.yellowAccent, Colors.deepOrange],
                          ),
                          unselectedGradientColor: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Colors.redAccent, Colors.blue],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text('Profile Completion'),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            shape: BoxShape.rectangle,
                            color: Colors.black,
                            border: Border()),
                        child: Text(studentData.name.toUpperCase(),
                            style: const TextStyle(color: Colors.white)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      studentData.image != null
                          ? CircleAvatar(
                              backgroundImage: studentData.image != null
                                  ? FileImage(File(studentData.image!))
                                  : null,
                              radius: 50,
                            )
                          : const CircleAvatar(
                              backgroundColor: Colors.grey,
                              radius: 60,
                              child: Icon(Icons.add_a_photo_outlined),
                            ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              // update value
              Card(
                color: Colors.grey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      child: Text(studentData.domain!,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 20)),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              //Show value
              SizedBox(
                height: 150,
                child: Card(
                  elevation: 10,
                  // margin: EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Colors.grey.shade900,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${studentData.week}\nWeek',
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          '${studentData.hub!.toUpperCase()} - ${studentData.batch}\nBatch',
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          '${studentData.score}\nScore',
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }

  // late List myData;
  // void myProfileData() {
  //   if (FirebaseAuth.instance.currentUser!.email == studentData.email) {
  //     myData.add(studentData);
  //   } else {
  //     return;
  //   }
  // }
}
