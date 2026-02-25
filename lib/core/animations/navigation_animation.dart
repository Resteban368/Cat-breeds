import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum TipeAnimation {
  fade,
  slide,
  scale,
}

CustomTransitionPage<void> navigationAnimation({
  required BuildContext context,
  required Widget page,
  required TipeAnimation tipeAnimation,
}) {
  return CustomTransitionPage(
    child: page,
    transitionDuration: const Duration(milliseconds: 600),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      switch (tipeAnimation) {
        case TipeAnimation.fade:
          return FadeTransition(
            opacity: Tween<double>(begin: 0, end: 1).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOut),
            ),
            child: child,
          );
        case TipeAnimation.slide:
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0), // Desde la derecha
              end: Offset.zero,
            ).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOut),
            ),
            child: child,
          );
        case TipeAnimation.scale:
          return ScaleTransition(
            scale: Tween<double>(begin: 0.8, end: 1).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOut),
            ),
            child: child,
          );
      }
    },
  );
}
