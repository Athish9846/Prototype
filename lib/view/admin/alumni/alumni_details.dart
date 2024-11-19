import 'package:flutter/material.dart';
import 'package:prototype/components/app_bar.dart';
import 'package:prototype/components/my_grid_tile.dart';

class AddAlumni extends StatelessWidget {
  const AddAlumni({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: MyAppBar(
                iconThemeData: const IconThemeData(color: Colors.white),
                automaticallyImplyLeading: true,
                appbartitle: 'D O M A I N')),
        body: const SafeArea(
          child: AlumniGridTile(
            navigate: Navigate.addAlumniDetails,
          ),
        ));
  }
}
