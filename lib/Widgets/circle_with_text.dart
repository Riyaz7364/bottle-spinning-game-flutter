import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

// class CircleWithText extends StatefulWidget {
//   const CircleWithText({super.key});

//   @override
//   State<CircleWithText> createState() => _CircleWithTextState();
// }

// class _CircleWithTextState extends State<CircleWithText> {

//   @override
//   Widget build(BuildContext context) {
//     return
//   }
// }

class TextCirclePainter extends CustomPainter {
  final List<String> textItems;

  TextCirclePainter(this.textItems);

  @override
  void paint(Canvas canvas, Size size) {
    final double outerRadius = min(size.width / 2, size.height / 2) - 20;
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double angleStep = 2 * pi / textItems.length;

    final List<Color> colors = [
      Colors.amber,
      Colors.grey,
      Colors.blue,
      Colors.red,
      Colors.orange,
      Colors.purple,
      Colors.cyan,
      Colors.pink,
    ];

    // Draw each segment with a different color
    for (int i = 0; i < textItems.length; i++) {
      final double startAngle = -pi / 2 -
          i * angleStep; // Start from top right corner and go counter-clockwise
      final double sweepAngle =
          -angleStep; // Sweep angle should be negative for counter-clockwise

      final Paint segmentPaint = Paint()
        ..color = colors[i % colors.length]
        ..style = PaintingStyle.fill;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: outerRadius),
        startAngle,
        sweepAngle,
        true,
        segmentPaint,
      );
    }

    // Draw the circle outline
    final Paint circlePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0;

    canvas.drawCircle(center, outerRadius, circlePaint);

    // Draw the text items
    final double textRadius =
        outerRadius * 0.6; // Position text slightly inside the segment
    final TextPainter textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    for (int i = 0; i < textItems.length; i++) {
      final double angle = -pi / 2 -
          (i + 0.5) *
              angleStep; // Middle of the segment, starting from top right
      final double x = center.dx + textRadius * cos(angle);
      final double y = center.dy + textRadius * sin(angle);

      // Create the text span
      final textSpan = TextSpan(
        text: textItems[i],
        style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            shadows: []),
      );

      // Layout the text span
      textPainter.text = textSpan;
      textPainter.layout();

      // Calculate the position to center the text around the point
      final Offset textOffset = Offset(
        x - textPainter.width / 2,
        y - textPainter.height / 2,
      );

      // Draw the text
      textPainter.paint(canvas, textOffset);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
