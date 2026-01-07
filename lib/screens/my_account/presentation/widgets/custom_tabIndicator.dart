import 'package:flutter/material.dart';

class CustomTabIndicator extends Decoration {
  final Color color;
  final double height;

  CustomTabIndicator({required this.color, required this.height});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CustomTabIndicatorPainter(color: color, height: height);
  }
}

class _CustomTabIndicatorPainter extends BoxPainter {

  final Color color;
  final double height;

  _CustomTabIndicatorPainter({required this.color, required this.height});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Calculate the indicator's position and size
    final double indicatorWidth = configuration.size!.width;
    final double indicatorHeight = height;
    final double xPos = offset.dx;
    final double yPos = offset.dy + configuration.size!.height - height;

    final Rect rect = Rect.fromLTWH(xPos, yPos, indicatorWidth, indicatorHeight);
    canvas.drawRect(rect, paint);
  }
}