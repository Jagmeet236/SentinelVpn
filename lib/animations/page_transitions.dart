import 'package:flutter/material.dart';

class SlideAnimationScreen extends StatelessWidget {
  final Widget child;

  SlideAnimationScreen({required this.child});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<Offset>(
      duration: const Duration(seconds: 1), // Adjust the duration as needed
      tween: Tween<Offset>(begin: Offset(1, 0), end: Offset.zero),
      builder: (BuildContext context, Offset value, Widget? child) {
        return FractionalTranslation(
          translation: value,
          child: child,
        );
      },
      child: child,
    );
  }
}

///FADE ANIMATION
class FadeAnimationScreen extends StatelessWidget {
  final Widget child;

  FadeAnimationScreen({required this.child});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(seconds: 1), // Adjust the duration as needed
      tween: Tween<double>(begin: 0, end: 1),
      builder: (BuildContext context, double value, Widget? child) {
        return Opacity(
          opacity: value,
          child: child,
        );
      },
      child: child,
    );
  }
}
