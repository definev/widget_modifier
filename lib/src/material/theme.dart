import 'package:declarative_widget_modifier/src/widgets/implicit_animations.dart';
import 'package:flutter/material.dart';
import 'package:nested/nested.dart';

class ThemeModifier extends SingleChildStatelessWidget {
  const ThemeModifier({
    super.key,
    super.child,
    this.modifierKey,
    required this.data,
  });

  final Key? modifierKey;
  final ThemeData data;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return Theme(
      key: modifierKey,
      data: data,
      child: child!,
    );
  }
}

class AnimatedThemeModifier extends SingleChildImplicitlyAnimatedWidget {
  const AnimatedThemeModifier({
    super.key,
    super.child,
    this.modifierKey,
    required this.data,
    super.curve,
    super.duration = kThemeAnimationDuration,
    super.onEnd,
  });

  final Key? modifierKey;
  final ThemeData data;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return AnimatedTheme(
      key: modifierKey,
      data: data,
      curve: curve,
      duration: duration,
      onEnd: onEnd,
      child: child!,
    );
  }
}
