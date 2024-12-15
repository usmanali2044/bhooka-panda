import 'package:flutter/material.dart';

class SlidePageRoute extends PageRouteBuilder {
  final Widget page;
  final AxisDirection direction;

  SlidePageRoute({required this.page, required this.direction})
      : super(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const beginOffsetMap = {
        AxisDirection.up: Offset(0, 1),
        AxisDirection.down: Offset(0, -1),
        AxisDirection.left: Offset(1, 0),
        AxisDirection.right: Offset(-1, 0),
      };

      final begin = beginOffsetMap[direction]!;
      const end = Offset.zero;
      const curve = Curves.easeInOut;

      final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      final offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}