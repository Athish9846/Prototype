// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:prototype/components/my_textfield.dart';
// import 'package:prototype/models/admin_batch_model.dart';

// class AddBatch extends StatelessWidget{

//     final _batchController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
// Future<void> _onPress() async {
//     showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//               backgroundColor: Colors.grey[300],
//               title: const Text('ADD BATCHES'),
//               // icon: Icon(Icons.add),
//               content: Form(
//                 key: _formKey,
//                 child: MyTextField(
//                   controller: _batchController,
//                   hintText: '109',
//                   labelText: '',
//                   obscureText: false,
//                   validator: 'Add Data',
//                   keyBoard: TextInputType.number,
//                 ),
//               ),
//               // TextField(
//               //   controller: _batchController,
//               // ),
//               actions: [
//                 (ElevatedButton.icon(
//                     style: const ButtonStyle(
//                         // minimumSize: MaterialStatePropertyAll(Size(10, 20)),
//                         fixedSize: MaterialStatePropertyAll(Size(120, 15)),
//                         backgroundColor:
//                             MaterialStatePropertyAll(Colors.black87)),
//                     onPressed: () {
//                       //  clear();
//                       if (_formKey.currentState!.validate()) {
//                         buttonClicked(context);
//                       }
//                     },
//                     icon: const Icon(Icons.add),
//                     label: const Text(' Domains')))
//               ],
//             ));
//   }
//   Future<void> buttonClicked(BuildContext context) async {
//     final batchinput = _batchController.text;
//     if (batchinput.isEmpty || batchinput.length > 4) {
//       return;
//     } else {
//       final batchesdata = AddBatchModel(batch: batchinput);
//       await addbatches(batchesdata);
//       // print(batches.value);
//       Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (context) => ShowBatches(
//                     batch: batches.value.toString(),
//                   )));
//       clear();
//     }
//   }
// }