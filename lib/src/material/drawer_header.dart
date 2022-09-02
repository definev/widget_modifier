import 'package:flutter/material.dart';
import 'package:nested/nested.dart';

class DrawerHeaderModifier extends SingleChildStatelessWidget {
  const DrawerHeaderModifier({
    Key? key,
    Widget? child,
    this.modifierKey,
    this.decoration,
    this.margin = const EdgeInsets.only(bottom: 8.0),
    this.padding = const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
    this.duration = const Duration(milliseconds: 250),
    this.curve = Curves.fastOutSlowIn,
  }) : super(key: key, child: child);

  final Key? modifierKey;
  final Decoration? decoration;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final Duration duration;
  final Curve curve;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return DrawerHeader(
      key: modifierKey,
      curve: curve,
      decoration: decoration,
      duration: duration,
      margin: margin,
      padding: padding,
      child: child,
    );
  }
}
