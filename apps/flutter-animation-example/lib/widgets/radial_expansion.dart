import 'package:flutter/material.dart';
import 'dart:math' as math;

class RadialExpansion extends StatelessWidget {
  const RadialExpansion({
    Key? key,
    required this.maxRadius,
    required this.child
  }) : clipRectSize = 2.0 * (maxRadius / math.sqrt2), super(key: key);

  final double maxRadius;
  final clipRectSize;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Center(
        child: SizedBox(
          width: clipRectSize,
          height: clipRectSize,
          child: ClipRect(
            child: child,
          ),
        ),
      ),
    );
  }
}
