import 'package:flutter/material.dart';
import 'package:prototype/components/log_out.dart';
import 'package:prototype/components/my_textfield.dart';
import 'package:prototype/controller/hive_add_batch.dart';
import 'package:prototype/controller/hive_batch.dart';
import 'package:prototype/models/admin_batch_model.dart';
import 'package:prototype/view/admin/Alumni/alumni_details.dart';
import 'package:prototype/view/admin/attendence/studentdata/data_table.dart';
import 'package:prototype/view/admin/dashboard/home_page.dart';
import 'package:prototype/view/admin/BATCHES/show_batches.dart';
import 'package:prototype/view/admin/dashboard/report/dataepicker.dart';
import 'package:prototype/view/student/alumni/nav_alumni.dart';
import 'package:slide_to_act/slide_to_act.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final _batchController = TextEditingController();
  final List<List<String>> _admin = [
    ['assets/images/profile.jpeg', 'Student Profile'],
    [
      'assets/images/batches.png',
      'Batches',
    ],
    ['assets/images/alumni.png', 'Alumni'],
    ['assets/images/alumnipla.png', 'Alumni Placed'],
    ['assets/images/reports.png', 'Generate Reports']
  ];

  List<Widget> navigationPage = [
    // HomePage(batch: ''),
     HomePage(batch: '',),
    ShowBatches(batch: batches.value.toString()),
    const AddAlumni(),
    const ShowAlumniDomain(),
    // Report(attendance: [],presentStudents: [])
    DatePicker(presentStudent: batchNotifier.value,attandance: [],)
    
    // )
  ];

  // // navigation bottomBar
  // int _selectedIndex = 0;
  // // final currentIndex = _selectedIndex;

  // //pages
  // final List<Widget> bottomNavPages = [const AdminPage(), AttendencePage()];

  // void navigateBottomBar(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  //   // Navigator.push(context, MaterialPageRoute(builder: (ctx)=>bottomNavPages[index]));
  // }

  void clear() {
    _batchController.clear();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'A D M I N',
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
        centerTitle: true,
        actionsIconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
              onPressed: () {
                LogOut.showLogOutDialog(context);
              },
              icon: const Icon(Icons.logout)),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Admin Dashboard',
                  style: TextStyle(fontSize: 22),
                ),
                const SizedBox(
                  height: 25,
                ),

                ListView.builder(
                    key: UniqueKey(),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _admin.length,
                    itemBuilder: ((context, index) => Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          padding: const EdgeInsets.symmetric(
                              vertical: 25, horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            leading: Image(
                                height: 60,
                                width: 60,
                                image: AssetImage(_admin[index][0])),
                            title: Text(
                              _admin[index][1],
                              style: const TextStyle(fontSize: 18),
                            ),
                            trailing: (index == 0 || index == 3 || index == 4)
                                ? const Icon(null)
                                : IconButton(
                                    onPressed: () =>
                                        index == 1 ? _onPress() : null,
                                    icon: const Icon(Icons.add)),
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        navigationPage[index])),
                          ),
                        ))),
                // const StepProgressIndicator(
                //   totalSteps: 10,
                //   currentStep: 6,
                //   selectedColor: Colors.red,
                //   unselectedColor: Colors.yellow,
                // ),
                Builder(builder: (context) {
                  final GlobalKey<SlideActionState> key = GlobalKey();
                  return SlideAction(
                    // sliderButtonIconSize: 18,
                    // sliderButtonIconPadding: 5,
                    // height: 25,
                    text: 'Slide to mark',
                    textStyle: const TextStyle(color: Colors.red),
                    innerColor: Colors.grey.shade600,
                    outerColor: Colors.black,
                    onSubmit: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => StudentData(batches: '',)));
                      return null;
                    },
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onPress() async {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.grey[300],
              title: const Text('ADD BATCHES'),
              // icon: Icon(Icons.add),
              content: Form(
                key: _formKey,
                child: MyTextField(
                  controller: _batchController,
                  hintText: '109',
                  labelText: '',
                  obscureText: false,
                  validator: 'Add Data',
                  keyBoard: TextInputType.number,
                ),
              ),
              // TextField(
              //   controller: _batchController,
              // ),
              actions: [
                (ElevatedButton.icon(
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.black87)),
                    onPressed: () {
                      //  clear();
                      if (_formKey.currentState!.validate()) {
                        buttonClicked(context);
                      }
                    },
                    icon: const Icon(Icons.add),
                    label: const Text(' Domains')))
              ],
            ));
  }

  Future<void> buttonClicked(BuildContext context) async {
    final batchinput = _batchController.text;
    if (batchinput.isEmpty || batchinput.length > 4) {
      return;
    } else {
      final batchesdata = AddBatchModel(batch: batchinput);
      await addbatches(batchesdata);
      // print(batches.value);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => ShowBatches(
                    batch: batches.value.toString(),
                  )));
      clear();
    }
  }
}
