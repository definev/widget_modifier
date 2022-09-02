import 'package:flutter/material.dart';
import 'package:nested/nested.dart';

class BottomAppBarModifier extends SingleChildStatelessWidget {
  const BottomAppBarModifier({
    Key? key,
    Widget? child,
    this.modifierKey,
    this.color,
    this.elevation,
    this.shape,
    this.clipBehavior = Clip.none,
    this.notchMargin = 4.0,
  }) : super(key: key, child: child);

  final Key? modifierKey;
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
