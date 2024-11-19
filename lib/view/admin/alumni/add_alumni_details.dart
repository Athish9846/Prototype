import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prototype/components/app_bar.dart';
import 'package:prototype/components/my_button.dart';
import 'package:prototype/components/my_textfield.dart';
import 'package:prototype/controller/hive_alumni.dart';
import 'package:prototype/models/alumni_model.dart';
import 'package:prototype/view/student/alumni/show_alumni.dart';

class AddAlumniDetails extends StatefulWidget {
  final String? domainValues;
  const AddAlumniDetails({super.key, required this.domainValues});

  @override
  State<AddAlumniDetails> createState() => _AddAlumniDetailsState();
}

class _AddAlumniDetailsState extends State<AddAlumniDetails> {
  // final _imageController = TextEditingController();

  final _nameController = TextEditingController();
  final _batchController = TextEditingController();
  final _companyController = TextEditingController();
  final _ctcController = TextEditingController();
  final _countController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  void clear() {
    _nameController.clear();
    _batchController.clear();
    _companyController.clear();
    _countController.clear();
    _ctcController.clear();
  }

  File? _selectedImage;

  void _setImage(File image) {
    setState(() {
      _selectedImage = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('add alumni details ${widget.domainValues}');
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: MyAppBar(
            appbartitle: '',
            iconThemeData: const IconThemeData(color: Colors.white),
            automaticallyImplyLeading: true,
          )),
      // AppBar(
      //   backgroundColor: Colors.black87,
      //   title: const Text(
      //     '',
      //     style: TextStyle(
      //         // fontSize: 30,
      //         // color: Colors.white,
      //         ),
      //   ),
      //   centerTitle: true,
      // ),
      backgroundColor: Colors.grey[300],
      body: SafeArea(
          child: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              const SizedBox(
                height: 50.0,
              ),
              const Text(
                'ADD DETAILS',
                style: TextStyle(fontSize: 30),
              ),
              const SizedBox(
                height: 30.0,
              ),
              CircleAvatar(
                radius: 80,
                backgroundColor: Colors.grey[800],
                child: GestureDetector(
                    onTap: () async {
                      File? pickedImage = await _pickedImageFromGallery();
                      if (pickedImage != null) {
                        _setImage(pickedImage);
                      }
                    },
                    child: _selectedImage != null
                        ? ClipOval(
                            child: Image.file(
                              _selectedImage!,
                              fit: BoxFit.cover,
                              width: 140,
                              height: 140,
                            ),
                          )
                        : const Icon(Icons.add_a_photo_rounded)),
              ),
              const SizedBox(
                height: 60.0,
              ),
              // DecoratedBox(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)))
              MyTextField(
                  // focusNode: FocusNode(),
                  validator: 'Enter Name',
                  controller: _nameController,
                  keyBoard: TextInputType.name,
                  hintText: 'Athish TS',
                  labelText: 'Name',
                  obscureText: false),
              const SizedBox(
                height: 15,
              ),
              MyTextField(
                  // focusNode: FocusNode(),
                  validator: 'Enter Batch',
                  controller: _batchController,
                  keyBoard: TextInputType.number,
                  hintText: 'BCE - 109',
                  labelText: 'BCE',
                  obscureText: false),
              const SizedBox(
                height: 15,
              ),
              MyTextField(
                  // focusNode: FocusNode(),
                  validator: 'Enter Company',
                  controller: _companyController,
                  keyBoard: TextInputType.emailAddress,
                  hintText: 'Google',
                  labelText: 'Company',
                  obscureText: false),
              const SizedBox(
                height: 15,
              ),
              MyTextField(
                  // focusNode: FocusNode(),
                  validator: null,
                  controller: _ctcController,
                  keyBoard: TextInputType.number,
                  hintText: '10 LPA',
                  labelText: 'CTC',
                  obscureText: false),
              const SizedBox(
                height: 15,
              ),
              MyTextField(
                  // focusNode: FocusNode(),
                  validator: 'Count',
                  controller: _countController,
                  keyBoard: TextInputType.number,
                  hintText: '999',
                  labelText: 'Placement Count',
                  obscureText: false),
              const SizedBox(
                height: 35,
              ),
              AddButton(onTap: () {
                if (_formkey.currentState!.validate()) {
                  onButtonClicked(context);
                }
              })
            ],
          ),
        ),
      )),
    );
  }

  void onButtonClicked(BuildContext ctx) async {
    final name = _nameController.text;
    final batch = _batchController.text;
    final company = _companyController.text;
    final ctc = _ctcController.text;
    final count = _countController.text;

    if (_selectedImage == null ||
        name.isEmpty ||
        batch.isEmpty ||
        company.isEmpty ||
        count.isEmpty) {
      setState(() {
        _selectedImage = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
          content: Text(
            'Please select an image',
            style: TextStyle(color: Colors.white),
          )));
      return;
    } else {
      // _selectedImage = null;
      clear();
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (ctx) => ShowAlumniDetails(
                // domain: widget.domainValues,
                DomainValues: batch,
              )));
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
          content: Text('Updated Succefully',
              style: TextStyle(color: Colors.white))));
    }

    final alumniDetails = AlumniModel(
        name: name,
        batch: batch,
        company: company,
        ctc: ctc,
        count: count,
        domain: widget.domainValues,
        imageurl: _selectedImage != null ? _selectedImage!.path : null);

    await addAlumni(alumniDetails);
    setState(() {
      _selectedImage = null;
    });
  }

  Future<File?> _pickedImageFromGallery() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      return File(pickedImage.path);
    }
    return null;
  }

  @override
  void dispose() {
    _nameController.dispose;
    _batchController.dispose();
    _companyController.dispose();
    _ctcController.dispose();
    _countController.dispose();
    _formkey.currentState?.dispose();

    super.dispose();
  }
}
