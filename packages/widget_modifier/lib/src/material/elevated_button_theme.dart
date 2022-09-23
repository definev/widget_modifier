import 'package:widget_modifier/src/modifier.dart';
import 'package:flutter/material.dart';

class ElevatedButtonThemeModifier extends SingleChildStatelessModifier {
  const ElevatedButtonThemeModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    required this.data,
  }) : super(key: key, child: child);

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
