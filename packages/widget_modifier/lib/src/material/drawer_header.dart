import 'package:widget_modifier/src/modifier.dart';
import 'package:flutter/material.dart';

class DrawerHeaderModifier extends SingleChildStatelessModifier {
  const DrawerHeaderModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    this.decoration,
    this.margin = const EdgeInsets.only(bottom: 8.0),
    this.padding = const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
    this.duration = const Duration(milliseconds: 250),
    this.curve = Curves.fastOutSlowIn,
  }) : super(key: key, child: child);

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
