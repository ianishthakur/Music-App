import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterTextField extends StatelessWidget {
  const RegisterTextField({
    Key? key,
    required this.controller,
    this.obscureText = false,
    this.hintText = "",
    this.suffixIcon,
    this.focusNode,
    this.textInputAction = TextInputAction.next,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    required this.label, this.validator,
  }) : super(key: key);

  final TextEditingController controller;
  final bool obscureText;
  final String hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 6.0),
          child: Text(label,
              style: GoogleFonts.bitter(
                  textStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ))),
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.disabled,
          controller: controller,
          obscureText: obscureText,
          focusNode: focusNode,
          style: GoogleFonts.bitter(
              textStyle:
                  const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(fontSize: (14), color: Colors.grey),
            border: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF222c33), width: 1),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFF222c33),
              ),
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 1,
                  color: Color(0xFF222c33),
                ),
                borderRadius: BorderRadius.circular(14)),
            errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 1, color: Colors.red),
                borderRadius: BorderRadius.circular(14)),
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
          ),
        ),
      ],
    );
  }
}
