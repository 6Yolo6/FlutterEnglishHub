import 'package:flutter/material.dart';

class CustomImagePainter extends CustomPainter {
  final String bookName;
  final String imagePath;

  CustomImagePainter({required this.bookName, required this.imagePath});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.fill;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    final textPainter = TextPainter(
      text: TextSpan(
        text: bookName,
        style: TextStyle(color: Colors.white, fontSize: 14),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(minWidth: size.width, maxWidth: size.width);
    textPainter.paint(canvas, Offset(0, size.height / 2 - textPainter.height / 2));
  }

  @override
  bool shouldRepaint(CustomImagePainter oldDelegate) {
    return false;
  }
}