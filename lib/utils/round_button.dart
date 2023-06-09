import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {

  double height;
  double width;
  double size;
  Icon icon;
   RoundButton({super.key, required this.height, required this.width, required this.icon, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(
              1.0,
              5.0,
            ),
            blurRadius: 6.0,
            spreadRadius: 2.0,
          ), //BoxShadow//BoxShadow
        ],
        borderRadius: BorderRadius.circular(50),
        color: const Color(0xFF3E8B3A),
      ),
      child:  Center(
          child: Icon(icon.icon, color: Colors.white, size: size,)
      ),
    );
  }
}