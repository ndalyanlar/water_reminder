import 'package:flutter/material.dart';

class MyPainter extends CustomPainter {
  final double firstValue;
  final double secondValue;
  final double thirdValue;
  final double fourthValue;

  MyPainter(
    this.firstValue,
    this.secondValue,
    this.thirdValue,
    this.fourthValue,
  );

  String? name;

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = const Color(0xff9ecfe6).withOpacity(.8)
      ..style = PaintingStyle.fill;

    var path = Path()
      ..addRRect(
        BorderRadius.circular(45).toRRect(
          const Rect.fromLTRB(40, 40, 40, 40),
        ),
      )
      ..moveTo(1, size.height / firstValue)
      ..cubicTo(size.width * .4, size.height / secondValue, size.width * .7,
          size.height / thirdValue, size.width, size.height / fourthValue)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return this != oldDelegate;
  }
}
