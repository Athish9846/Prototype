import 'package:flutter/material.dart';
import 'package:prototype/controller/hive_alumni.dart';
import 'package:prototype/models/alumni_model.dart';

// final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class ShowDeleteDialog {
  static Future<Widget?> showDeleteConformationDialog(
      BuildContext context, AlumniModel list) async {
    return showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text('Conformation Delete'),
            content: const Text('Are you sure want to delete ?'),
            actions: [
              TextButton(
                  onPressed: () {
                    deleteAlumni(list);
                    Navigator.pop(context);
                  },
                  child: const Text('Yes')),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('No')),
            ],
          );
        });
  }
}
