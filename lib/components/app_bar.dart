import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
String appbartitle;
IconThemeData? iconThemeData;
bool? automaticallyImplyLeading;
  MyAppBar({super.key,required this.appbartitle,this.iconThemeData,this.automaticallyImplyLeading});

  @override
  Widget build(BuildContext context) {
    return AppBar(title:Text(appbartitle),
    iconTheme:iconThemeData ,
    automaticallyImplyLeading: automaticallyImplyLeading!,
    centerTitle: true,
    titleTextStyle: TextStyle(color: Colors.white,
    fontSize: 25
    ),
    
    );
  }
}
