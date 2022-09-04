import 'package:declarative_widget_modifier/src/modifier.dart';
import 'package:flutter/material.dart';

class MaterialModifier extends SingleChildStatelessModifier {
  const MaterialModifier({
    super.key,
    super.child,
    super.modifierKey,
    this.type = MaterialType.canvas,
    this.elevation = 0.0,
    this.color,
    this.shadowColor,
    this.surfaceTintColor,
    this.textStyle,
    this.borderRadius,
    this.shape,
    this.borderOnForeground = true,
    this.clipBehavior = Clip.none,
    this.animationDuration = kThemeChangeDuration,
  });

  final MaterialType type;
  final double elevation;
  final Color? color;
  final Color? shadowColor;
  final Color? surfaceTintColor;
  final TextStyle? textStyle;
  final ShapeBorder? shape;
  final bool borderOnForeground;
  final Clip clipBehavior;
  final Duration animationDuration;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return Material(
      key: modifierKey,
      animationDuration: animationDuration,
      borderOnForeground: borderOnForeground,
      borderRadius: borderRadius,
      clipBehavior: clipBehavior,
      color: color,
      elevation: elevation,
      shadowColor: shadowColor,
      shape: shape,
      surfaceTintColor: surfaceTintColor,
      textStyle: textStyle,
      type: type,
      child: child,
    );
  }
}
