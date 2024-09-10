import 'package:flutter/material.dart';
import 'package:home_test_flutter/commons/color.dart';

class LoginTextField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final bool obscureText;
  final Widget? suffixIcon;

  const LoginTextField({
    Key? key,
    required this.label,
    required this.controller,
    required this.obscureText,
    this.suffixIcon
  }) : super(key: key);

  @override
  State<LoginTextField> createState() => _LoginTextFieldState();
}

class _LoginTextFieldState extends State<LoginTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black
          ),
        ),
        TextField(
          controller: widget.controller,
          obscureText: widget.obscureText,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: ColorValues.greyWhite),
              borderRadius: BorderRadius.circular(30)
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: ColorValues.purplePastel),
              borderRadius: BorderRadius.circular(30)
            ),
            suffixIcon: widget.suffixIcon
          ),
        )
      ],
    );
  }
}