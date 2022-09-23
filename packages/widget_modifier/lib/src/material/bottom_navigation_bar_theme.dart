import 'package:widget_modifier/src/modifier.dart';
import 'package:flutter/material.dart';

class BottomNavigationBarThemeModifier extends SingleChildStatelessModifier {
  const BottomNavigationBarThemeModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    required this.data,
  }) : super(key: key, child: child);

  final BottomNavigationBarThemeData data;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return BottomNavigationBarTheme(
      key: modifierKey,
      data: data,
      child: child!,
    );
  }
}
