import 'package:widget_modifier/src/modifier.dart';
import 'package:flutter/material.dart';

class BottomAppBarModifier extends SingleChildStatelessModifier {
  const BottomAppBarModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    this.color,
    this.elevation,
    this.shape,
    this.clipBehavior = Clip.none,
    this.notchMargin = 4.0,
  }) : super(key: key, child: child);

  final Color? color;
  final double? elevation;
  final NotchedShape? shape;
  final Clip clipBehavior;
  final double notchMargin;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return BottomAppBar(
      key: modifierKey,
      clipBehavior: clipBehavior,
      color: color,
      elevation: elevation,
      notchMargin: notchMargin,
      shape: shape,
      child: child,
    );
  }
}
