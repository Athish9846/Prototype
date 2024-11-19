import 'dart:io';
import 'package:flutter/material.dart';
import 'package:prototype/components/my_textfield.dart';
import 'package:prototype/controller/hive_add_batch.dart';
import 'package:prototype/controller/hive_batch.dart';
import 'package:prototype/models/admin_model.dart';
import 'package:prototype/view/admin/ATTENDENCE/studentAttendence.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

ValueNotifier<BatchModel?> student = ValueNotifier(null);

class ShowProfile extends StatefulWidget {
  final BatchModel studentData;
  const ShowProfile({
    super.key,
    required this.studentData,
  });

  @override
  State<ShowProfile> createState() => _ShowProfileState();
}

class _ShowProfileState extends State<ShowProfile> {
  final TextEditingController _updatedWeekController = TextEditingController();
  final TextEditingController _updatedScoreController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  void clear() {
    _updatedScoreController.clear();
    _updatedWeekController.clear();
  }

  @override
  void initState() {
    student.value = widget.studentData;
    getValue();
    getBatches();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'STUDENT PROFILE',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.dark_mode))
        ],
      ),
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
                        child: Text(widget.studentData.name.toUpperCase(),
                            style: const TextStyle(color: Colors.white)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      widget.studentData.image != null
                          ? CircleAvatar(
                              backgroundImage: widget.studentData.image != null
                                  ? FileImage(File(widget.studentData.image!))
                                  : null,
                              radius: 50,
                            )
                          : const CircleAvatar(
                              backgroundColor: Colors.grey,
                              radius: 60,
                              child: Icon(Icons.add_a_photo_outlined),
                            ),
                      // Container(
                      //   height: 110,
                      //   width: 110,
                      //   decoration: BoxDecoration(
                      //     // color: Colors.amberAccent,
                      //     image: widget.studentData.image != null
                      //         ? DecorationImage(
                      //             fit: BoxFit.cover,
                      //             image: FileImage(
                      //                 File(widget.studentData.image!)),
                      //           )
                      //         : null,
                      //   ),
                      //   child: widget.studentData.image != null
                      //       ? ClipOval(
                      //           child: Image.file(
                      //             File(widget.studentData.image!),
                      //             fit: BoxFit.cover,
                      //           ),
                      //         )
                      //       : const Icon(
                      //           Icons.add_a_photo_outlined,
                      //           color: Colors.grey,
                      //           size: 80,
                      //         ),
                      // ),
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
                    TextButton.icon(
                        onPressed: () {
                          onUpdate(context);
                        },
                        icon: const Icon(
                          Icons.update_outlined,
                          color: Colors.black,
                        ),
                        label: const Text(
                          'Tap to update',
                          style: TextStyle(color: Colors.black),
                        )),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      // decoration: const BoxDecoration(
                      //     borderRadius: BorderRadius.all(Radius.circular(10)),
                      //     shape: BoxShape.rectangle,
                      //     color: Colors.black,
                      //     border: Border()),
                      child: Text(widget.studentData.domain!,
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
                child: ValueListenableBuilder(
                  valueListenable: student,
                  builder: (context, value, child) {
                    return Card(
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
                              '${value!.week}\nWeek',
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              '${widget.studentData.hub!.toUpperCase()} - ${widget.studentData.batch}\nBatch',
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              '${value.score}\nScore',
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              //
              // Align(
              //   alignment: Alignment.centerLeft,
              //   child: IconButton(
              //       onPressed: () {
              //         // Navigator.push(
              //         //     context,
              //         //     MaterialPageRoute(
              //         //         builder: (ctx) => const StudentAttendence()));
              //       },
              //       icon: const Icon(
              //         Icons.calendar_month,
              //         size: 50,
              //       )),
              // ),
              const Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  height: 360,
                  width: 300,
                  child: StudentAttendence(),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }

  Future<void> onUpdate(context) async {
    showDialog(
        context: context,
        builder: (ctx) {
          return Form(
            key: _formKey,
            child: AlertDialog(
              // icon: Icon(Icons.abc_outlined),
              // iconPadding: EdgeInsets.all(30),
              backgroundColor: Colors.grey,
              title: const Text('UPDATE DETAILS'),
              // actionsAlignment:MainAxisAlignment.center,
              // alignment: Alignment.centerLeft,
              actions: [
                MyTextField(
                    controller: _updatedWeekController,
                    hintText: 'Week',
                    labelText: 'Week',
                    obscureText: false,
                    validator: 'Enter correct data',
                    keyBoard: TextInputType.phone),
                const SizedBox(
                  height: 20,
                ),
                MyTextField(
                    controller: _updatedScoreController,
                    hintText: 'Score',
                    labelText: 'Score',
                    obscureText: false,
                    validator: 'Enter correct data',
                    keyBoard: TextInputType.phone),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: ElevatedButton(
                      style: const ButtonStyle(
                          // alignment: Alignment.center,
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.black),
                          padding: MaterialStatePropertyAll(
                              EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 15))),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            buttonClicked(context);
                          });
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Updated Successfully'),
                            backgroundColor: Colors.green,
                            behavior: SnackBarBehavior.floating,
                            duration: Duration(seconds: 2),
                          ));
                        }
                      },
                      child: const Text('Update')),
                )
              ],
            ),
          );
        });
  }

  Future<void> buttonClicked(BuildContext context) async {
    final updateWeek = _updatedWeekController.text;
    final updateScore = _updatedScoreController.text;
    final updateStudent = BatchModel(
        name: widget.studentData.name,
        email: widget.studentData.email,
        hub: widget.studentData.hub,
        batch: widget.studentData.batch,
        domain: widget.studentData.domain,
        week: updateWeek,
        score: updateScore,
        image: widget.studentData.image,
        id: widget.studentData.id);

    // if (widget.studentData.week.length > 3 || updateScore.length > 3) {
    //   return;
    // } else {
    //   widget.studentData.week = updateWeek;
    //   widget.studentData.score = updateScore;
    // }
    student.value = updateStudent;
    updateValue(updateStudent);

    await getValue();

    clear();
  }

  @override
  void dispose() {
    _updatedScoreController.dispose();
    _updatedWeekController.dispose();
    super.dispose();
  }
}
