import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyButton extends StatelessWidget {
  String title;
  int color;
  bool isFullWidth;
  bool isOutlined;
  Function() onTap;

  MyButton({super.key,  this.isFullWidth = false, this.isOutlined = false,  required this.title,  required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: isFullWidth ? double.infinity : null,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: isOutlined ? Colors.transparent : Color(color),
          borderRadius: BorderRadius.circular(5),
          border: isOutlined ? Border.all(color: Color(color), width: 2) : null,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.lato(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
