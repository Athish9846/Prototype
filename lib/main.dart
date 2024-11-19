import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:prototype/models/admin_batch_model.dart';
import 'package:prototype/models/admin_model.dart';
import 'package:prototype/models/alumni_model.dart';
import 'package:prototype/models/attendence_model.dart';
import 'package:prototype/splash_screen.dart';
import 'firebase_options.dart';

const SAVE_KEY_NAME = 'UserLogged';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(BatchModelAdapter().typeId)) {
    Hive.registerAdapter(BatchModelAdapter());
  }
  if (!Hive.isAdapterRegistered(AlumniModelAdapter().typeId)) {
    Hive.registerAdapter(AlumniModelAdapter());
  }
  if (!Hive.isAdapterRegistered(AddBatchModelAdapter().typeId)) {
    Hive.registerAdapter(AddBatchModelAdapter());
  }
  if (!Hive.isAdapterRegistered(AttendanceModelAdapter().typeId)) {
    Hive.registerAdapter(AttendanceModelAdapter());
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        // title: 'Flutter Demo',
        theme: ThemeData(
          appBarTheme:
              AppBarTheme(backgroundColor: Color.fromARGB(221, 0, 0, 0)),
          // colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
          // useMaterial3: true,
        ),
        home: SplashScreen());
  }
}
