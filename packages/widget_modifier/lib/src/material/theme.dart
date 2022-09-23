import 'package:widget_modifier/src/modifier.dart';
import 'package:widget_modifier/src/widgets/implicit_animations.dart';
import 'package:flutter/material.dart';

class ThemeModifier extends SingleChildStatelessModifier {
  const ThemeModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.data,
  });

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
    super.modifierKey,
    required this.data,
    super.curve,
    super.duration = kThemeAnimationDuration,
    super.onEnd,
  });

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
