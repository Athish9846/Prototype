import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prototype/components/app_bar.dart';
import 'package:prototype/components/my_button.dart';
import 'package:prototype/components/my_textfield.dart';
import 'package:prototype/controller/hive_batch.dart';
import 'package:prototype/models/admin_model.dart';
import 'package:prototype/view/admin/dashboard/home_page.dart';

class AddBatchesDetails extends StatefulWidget {
  final String? DomainValues;
  final String? batch;
  const AddBatchesDetails({super.key, required this.DomainValues, this.batch});

  @override
  State<AddBatchesDetails> createState() => _AddBatchesDetailsState();
}

class _AddBatchesDetailsState extends State<AddBatchesDetails> {
  final _nameController = TextEditingController();
  // final _domainController = TextEditingController();
  // final _batchController = TextEditingController();
  final _emailController = TextEditingController();
  final _hubController = TextEditingController();
  final _scoreController = TextEditingController();
  final _currentweekController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  void clear() {
    _nameController.clear();
    // _batchController.clear();
    // _domainController.clear();
    _scoreController.clear();
    _currentweekController.clear();
    _hubController.clear();
    _emailController.clear();
  }

  File? _selectedImages;
  void _setImages(File image) {
    setState(() {
      _selectedImages = image;
    });
  }

  final List<List<String>> _status = [
    [
      'assets/images/ongoingstudent.png',
      'On Going',
    ],
    ['assets/images/graduated.png', 'Completed'],
  ];
  int _selectedStatusIndex = -1;
  final bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    print(widget.DomainValues);
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: MyAppBar(
            appbartitle: 'ADD STUDENT',
            automaticallyImplyLeading: true,
            iconThemeData: const IconThemeData(color: Colors.white),
          )),
      //  AppBar(
      //   backgroundColor: Colors.black,
      //   title: const Text(
      //     'ADD STUDENT',
      //     style: TextStyle(fontSize: 25),
      //   ),
      //   centerTitle: true,
      // ),
      body: SafeArea(
          child: Form(
        key: _formkey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              GestureDetector(
                onTap: () async {
                  File? pickedImages = await _pickImagesFromGallery();
                  if (pickedImages != null) {
                    _setImages(pickedImages);
                  }
                },
                child: CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.grey[800],
                  child: _selectedImages != null
                      ? ClipOval(
                          child: Image.file(
                          _selectedImages!,
                          fit: BoxFit.cover,
                          width: 150,
                          height: 150,
                        ))
                      : const Icon(Icons.add_a_photo_outlined),
                ),
              ),
              const SizedBox(height: 30),
              Card(
                // height: 60,
                // width: 130,
                margin: const EdgeInsets.only(left: 250, right: 25),
                color: Colors.grey.shade200,

                //       child: TextFormField(
                //         decoration: InputDecoration(
                //   enabledBorder: const OutlineInputBorder(
                //       borderSide: BorderSide(color: Colors.white)),
                //   focusedBorder: OutlineInputBorder(
                //     borderSide: BorderSide(color: Colors.grey.shade400),
                //   ),
                //   fillColor: Colors.grey.shade200,
                //   filled: true,
                //  ),
                //       ),
                // decoration:
                // BoxDecoration(

                //     borderRadius:BorderRadius.all(Radius.circular(5)) ,
                //     color: Colors.grey.shade200,),
                child: ExpansionTile(
                  // key: _expansionTileKey,
                  onExpansionChanged: (expanded) {
                    // if (!expanded) {
                    //   // _expansionTileKey.currentState?.collapse();
                    // }
                  },
                  tilePadding: const EdgeInsets.symmetric(horizontal: 20),
                  childrenPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  initiallyExpanded: _isExpanded,
                  // expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  title: Text(
                    _selectedStatusIndex == -1
                        ? 'S T A T U S'
                        : _status[_selectedStatusIndex][1],
                    style: const TextStyle(fontSize: 18),
                  ),
                  // _onTap
                  //     ? const Text(
                  //         'S T A T U S',
                  //         style: TextStyle(fontSize: 18),
                  //       )
                  //     : const Text(_status[index][1]),
                  children: [
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () => setState(() {
                          _selectedStatusIndex = index;
                          // _expansionTileKey.currentState?.collapse();
                        }),
                        child: ListTile(
                          leading: Image.asset(
                            _status[index][0],
                            width: 30,
                            height: 30,
                          ),
                          title: Text(
                            _status[index][1],
                            style: const TextStyle(),
                          ),
                        ),
                      ),
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: _status.length,

                      // Divider(),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              MyTextField(
                  // focusNode: FocusNode(),
                  validator: 'Enter Username',
                  controller: _nameController,
                  keyBoard: TextInputType.name,
                  hintText: '',
                  labelText: 'Name',
                  obscureText: false),
              const SizedBox(
                height: 10,
              ),
              // MyTextField(
              //     // focusNode: FocusNode(),
              //     validator: 'Enter Batch',
              //     controller: _batchController,
              //     keyBoard: TextInputType.number,
              //     hintText: 'BCE',
              //     labelText: 'Batch',
              //     obscureText: false),
              // const SizedBox(
              //   height: 10,
              // ),
              // MyTextField(
              //     // focusNode: FocusNode(),
              //     validator: 'Enter Domain',
              //     controller: _domainController,
              //     keyBoard: TextInputType.name,
              //     hintText: '',
              //     labelText: 'Domain',
              //     obscureText: false),
              // const SizedBox(
              //   height: 10,
              // ),
              MyTextField(
                  controller: _emailController,
                  hintText: '...123@gmail.com',
                  labelText: 'Email',
                  obscureText: false,
                  validator: 'Enter Email',
                  keyBoard: TextInputType.emailAddress),
              const SizedBox(
                height: 10,
              ),
              MyTextField(
                  controller: _hubController,
                  hintText: '',
                  labelText: 'Hub',
                  obscureText: false,
                  validator: 'Enter Hub',
                  keyBoard: TextInputType.emailAddress),
              const SizedBox(
                height: 10,
              ),
              // Container(
              //     // padding: EdgeInsets.all(1),
              //     margin: const EdgeInsets.symmetric(horizontal: 25),
              //     decoration: BoxDecoration(
              //       color: Colors.grey.shade200,
              //       border: Border.all(
              //         color: Colors.white,
              //       ),
              //     ),

              //     //     InputDecoration(
              //     // enabledBorder: const OutlineInputBorder(
              //     //     borderSide: BorderSide(color: Colors.white)),
              //     // focusedBorder: OutlineInputBorder(
              //     //   borderSide: BorderSide(color: Colors.grey.shade400),
              //     // ),
              //     // fillColor: Colors.grey.shade200,
              //     // filled: true,
              //     child: ExpansionTile(
              //         title: Text(
              //       'HUB',
              //       style: TextStyle(
              //           color: Colors.grey[500], fontWeight: FontWeight.w500),
              //     ))),
              // const SizedBox(
              //   height: 10,
              // ),
              MyTextField(
                  // focusNode: FocusNode(),
                  validator: 'Enter Current Week',
                  controller: _currentweekController,
                  keyBoard: TextInputType.number,
                  hintText: '25',
                  labelText: 'Week',
                  obscureText: false),
              const SizedBox(
                height: 10,
              ),
              MyTextField(

                  // focusNode: FocusNode(),
                  validator: 'Enter Score',
                  controller: _scoreController,
                  keyBoard: TextInputType.number,
                  hintText: '499',
                  labelText: 'Total Score',
                  obscureText: false),
              const SizedBox(
                height: 20,
              ),
              AddButton(onTap: () {
                if (_formkey.currentState!.validate()) {
                  onButtonaddBatchclicked();
                }
              })
            ],
          ),
        ),
      )),
    );
  }

  void onButtonaddBatchclicked() {
    final name = _nameController.text.trim();
    // final batch = _batchController.text.trim();
    // final domain = _domainController.text.trim();
    final week = _currentweekController.text.trim();
    final score = _scoreController.text.trim();
    final email = _emailController.text.trim();
    final hub = _hubController.text.trim();
    if (week.length > 2 || _selectedImages == null) {
      // setState(() {
      //   _selectedImages = null;
      // });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
          content: Text(
            'Please select an image',
            style: TextStyle(color: Colors.white),
          )));
      return;
    } else {
      clear();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
          content: Text('Updated Succefully',
              style: TextStyle(color: Colors.white))));

      final addBatchDetails = BatchModel(
        name: name,
        email: email,
        hub: hub,
        batch: widget.batch!,
        domain: widget.DomainValues,
        week: week,
        score: score,
        image: _selectedImages != null ? _selectedImages!.path : null,
      );

      addBatch(addBatchDetails);
      setState(() {
        _selectedImages = null;
      });
      Navigator.of(context).pushAndRemoveUntil(
       
        MaterialPageRoute(
          builder: (context) => HomePage(batch: widget.batch.toString())),
           (route)=>route.isFirst,
          );

      return;
    }
  }

  Future<File?> _pickImagesFromGallery() async {
    final pickedImages =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImages != null) {
      return File(pickedImages.path);
    } else {
      return null;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    // _batchController.dispose();
    // _domainController.dispose();
    _currentweekController.dispose();
    _scoreController.dispose();
    _formkey.currentState?.dispose();
    super.dispose();
  }
}
