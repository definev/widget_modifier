import 'package:flutter/material.dart';
import 'package:nested/nested.dart';

class ElevatedButtonThemeModifier extends SingleChildStatelessWidget {
  const ElevatedButtonThemeModifier({
    Key? key,
    Widget? child,
    this.modifierKey,
    required this.data,
  }) : super(key: key, child: child);

  final Key? modifierKey;
  final ElevatedButtonThemeData data;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return ElevatedButtonTheme(
      key: modifierKey,
      data: data,
      child: child!,
    );
  }
}
