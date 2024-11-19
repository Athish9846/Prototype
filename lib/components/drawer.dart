import 'package:flutter/material.dart';
import 'package:prototype/components/log_out.dart';
import 'package:prototype/components/my_list_tile.dart';
import 'package:prototype/view/student/data/my_profile.dart';

// ValueNotifier<BatchModel?> adminList = ValueNotifier(null);

class MyDrawer extends StatefulWidget {
  final Function()? onTap;
  // final Function()? onlogout;
  const MyDrawer({
    super.key,
    required this.onTap,
    //   required this.onlogout
  });

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  bool? isAdminValues = true;

  // Future<bool> isAdmin() async {
  //   final docRef = FirebaseFirestore.instance.doc('/users/<user_id>/isAdmin');
  //   final snapshot = await docRef.get();
  //   if (snapshot.exists) {
  //     return snapshot.data()!['isAdmin'] ?? false;
  //   } else {
  //     // Handle document not found case
  //     return false;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    //  To home
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              // header
              const DrawerHeader(
                  child: Icon(
                Icons.person,
                color: Colors.white,
                size: 64,
              )),

              // home list tile
              // isAdminValues!
              // ?
              MyListTile(
                icon: Icons.home,
                text: 'MY PROFILE',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (ctx)=>MyProfile()));
                  // myProfileData();
                },
              ),
              // : MyListTile(
              //     icon: Icons.home,
              //     text: 'H O M E',
              //     onTap: () {},
              //   ),
              //  profile list tile
              MyListTile(
                icon: Icons.person,
                text: 'A L U M N I',
                onTap: widget.onTap,
              )
            ],
          ),

          // Logout

          MyListTile(
              icon: Icons.logout_outlined,
              text: 'L O G O U T',
              onTap: () {
                LogOut.showLogOutDialog(context);
              })
        ],
      ),
    );
  }

  //  BatchModel? myData;
  // void myProfileData() {
  //   if (FirebaseAuth.instance.currentUser!.email == adminList.value!.email) {
  //      myData = adminList.value;
  //     Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //             builder: (ctx) => MyProfile(studentData: adminList.value!)));
  //   } else {
  //     return;
  //   }
  // }
}
