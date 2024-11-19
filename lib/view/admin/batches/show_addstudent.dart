import 'package:flutter/material.dart';
import 'package:prototype/components/app_bar.dart';
import 'package:prototype/components/my_grid_tile.dart';

class ShowAddStudent extends StatelessWidget {
  final String? batch;
  const ShowAddStudent({super.key, this.batch});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: MyAppBar(
            appbartitle: 'D O M A I N S',
            automaticallyImplyLeading: true,
            iconThemeData: const IconThemeData(color: Colors.white),
          )),
      body: AlumniGridTile(
        navigate: Navigate.addBatchesDetails,
        batch: batch,
      ),
    );
  }
}
