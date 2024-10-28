import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextFormField extends StatelessWidget {

  final controller;
  final String hintText;
  final bool obscureText;
  final String title;

  const MyTextFormField({
    super.key,
    this.controller,
    required this.hintText,
    required this.obscureText,
    required this.title
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.lato(
            fontSize: 18,
            color: Colors.white70,
            fontWeight: FontWeight.w400
          ),
        ),
        const SizedBox(height: 8,),
        TextFormField(
            controller: controller,
            obscureText: obscureText,
            style: const TextStyle(color: Colors.white70),
            decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(color: Colors.grey[600]),
                fillColor: const Color(0xff1D1D1D),
                filled: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(
                    color: Color(0xff979797),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                        color: Color(0xff8875FF)
                    )
                )
            )
        ),
      ],
    );
  }
}
