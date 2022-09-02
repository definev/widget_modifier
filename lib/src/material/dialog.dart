import 'package:flutter/material.dart';
import 'package:nested/nested.dart';

class DialogModifier extends SingleChildStatelessWidget {
  const DialogModifier({
    Key? key,
    Widget? child,
    this.modifierKey,
    this.backgroundColor,
    this.elevation,
    this.insetAnimationDuration = const Duration(milliseconds: 100),
    this.insetAnimationCurve = Curves.decelerate,
    this.insetPadding,
    this.clipBehavior = Clip.none,
    this.shape,
    this.alignment,
  }) : super(key: key, child: child);

  final Key? modifierKey;
  final Color? backgroundColor;
  final double? elevation;
  final Duration insetAnimationDuration;
  final Curve insetAnimationCurve;
  final EdgeInsets? insetPadding;
  final Clip clipBehavior;
  final ShapeBorder? shape;
  final AlignmentGeometry? alignment;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return Dialog(
      key: modifierKey,
      alignment: alignment,
      backgroundColor: backgroundColor,
      clipBehavior: clipBehavior,
      elevation: elevation,
      insetAnimationCurve: insetAnimationCurve,
      insetAnimationDuration: insetAnimationDuration,
      insetPadding: insetPadding,
      shape: shape,
      child: child,
    );
  }
}

class SimpleDialogOptionModifier extends SingleChildStatelessWidget {
  const SimpleDialogOptionModifier({
    Key? key,
    Widget? child,
    this.modifierKey,
    this.onPressed,
    this.padding,
  }) : super(key: key, child: child);

  final Key? modifierKey;
  final VoidCallback? onPressed;
  final EdgeInsets? padding;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return SimpleDialogOption(
      key: modifierKey,
      onPressed: onPressed,
      padding: padding,
      child: child,
    );
  }
}
