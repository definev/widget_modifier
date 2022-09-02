import 'package:flutter/material.dart';
import 'package:nested/nested.dart';

class CardModifier extends SingleChildStatelessWidget {
  const CardModifier({
    Key? key,
    Widget? child,
    this.modifierKey,
    this.color,
    this.shadowColor,
    this.surfaceTintColor,
    this.elevation,
    this.shape,
    this.borderOnForeground = true,
    this.margin,
    this.clipBehavior,
    this.semanticContainer = true,
  }) : super(key: key, child: child);

  final Key? modifierKey;
  final Color? color;
  final Color? shadowColor;
  final Color? surfaceTintColor;
  final double? elevation;
  final ShapeBorder? shape;
  final bool borderOnForeground;
  final Clip? clipBehavior;
  final EdgeInsetsGeometry? margin;
  final bool semanticContainer;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return Card(
      key: modifierKey,
      borderOnForeground: borderOnForeground,
      clipBehavior: clipBehavior,
      color: color,
      elevation: elevation,
      margin: margin,
      semanticContainer: semanticContainer,
      shadowColor: shadowColor,
      shape: shape,
      surfaceTintColor: surfaceTintColor,
      child: child,
    );
  }
}
