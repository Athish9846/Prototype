import 'package:flutter/material.dart';

enum Keyboard { text, email, number }

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final String labelText;
  final String? validator;
  final keyBoard;
  // final FocusNode focusNode;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.labelText,
    required this.obscureText,
    required this.validator,
    required this.keyBoard,
    // required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return validator;
          } else if (value.contains(value)) {
            return null;
          }
          return null;
        },

        // onEditingComplete: ()=>focusNode,
        controller: controller,
        keyboardType: keyBoard,
        obscureText: obscureText,
        decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            fillColor: Colors.grey.shade200,
            filled: true,
            hintText: hintText,
            labelText: labelText,
            labelStyle: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w300),
            hintStyle: TextStyle(color: Colors.grey[500])),
      ),
    );
  }
}
