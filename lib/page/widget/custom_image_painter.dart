import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

class CustomImagePainter extends StatelessWidget {
  final String bookName;
  final String imagePath;
  final double width;
  final double height;

  CustomImagePainter({
    required this.bookName, 
    required this.imagePath, 
    this.width = 70.0, 
    this.height = 150.0,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          imagePath,
          width: width,
          height: height,
          fit: BoxFit.contain,
        ),
        Container(
          width: width,
          height: height,
          alignment: Alignment.topCenter, 
          padding: EdgeInsets.only(top: 4), 
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.transparent, Colors.black54],
              begin: Alignment.bottomCenter, 
              end: Alignment.topCenter, 
            ),
          ),
          child: Text(
            bookName,
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  offset: Offset(1, 1),
                  color: Colors.black,
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}