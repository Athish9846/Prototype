import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prototype/components/landing_page.dart';
import 'package:prototype/view/authentication/login.dart';
import 'package:prototype/view/student/data/student_datatable.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(
        'assets/video/989a122ace8d0cdff137558ae4307378.mp4')
      ..initialize().then((value) {
        setState(() {});
        _controller.play();
      });

    Future.delayed(const Duration(seconds: 2), () {
      // checkUserLoggedIn();

      if (FirebaseAuth.instance.currentUser == null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (ctx) => Login(login: true)));
      } else {
        checkUserLoggedIn();
      }
    });
  }

  Future<void> checkUserLoggedIn() async {
    final firebaseLogIn = await FirebaseAuth.instance.currentUser!.email;
    if (firebaseLogIn == 'admin123@gmail.com') {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) => LandingPage()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (ctx) => StudentDataTable()));
    }
  }

  // Future<void> checkUserLoggedIn() async {
  //   final sharedprefs = await SharedPreferences.getInstance();
  //   final userLoggedIn = sharedprefs.getBool(SAVE_KEY_NAME);
  //   await Future.delayed(const Duration(seconds: 2));
  //   if (userLoggedIn == null || userLoggedIn == false) {
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (context) =>  Login()),
  //     );
  //   } else {
  //     Navigator.of(context).pushReplacement(
  //         MaterialPageRoute(builder: (ctx) => const StudentProfile()));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _controller.value.isInitialized
          ? VideoPlayer(_controller)
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
