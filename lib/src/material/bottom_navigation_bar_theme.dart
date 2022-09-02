import 'package:flutter/material.dart';
import 'package:nested/nested.dart';

class BottomNavigationBarThemeModifier extends SingleChildStatelessWidget {
  const BottomNavigationBarThemeModifier({
    Key? key,
    Widget? child,
    this.modifierKey,
    required this.data,
  }) : super(key: key, child: child);

  final Key? modifierKey;
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
